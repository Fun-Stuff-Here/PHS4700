function [finalPos faces] = RayTrace(problem, rays)

    stack = rays;

    finalPos = {};
    faces = [];

    while ~isempty(stack)

        [stack ray] = Pop(stack);

        if ray.nRebound >= problem.hyperParam.nRebondMax
            continue;
        end

        [doesRebound doesHitObject distance point normal color isEnteringSphere] = GetNextRebound(problem, ray);

        if doesHitObject
            total_distance = ray.distance + distance;
            finalPos{end+1} = ray.origin + total_distance * ray.origin_direction;
            faces(end+1) = color;
        elseif doesRebound
            ray.distance = ray.distance + distance;
            copy_ray = {};
            copy_ray.origin = ray.origin;
            copy_ray.origin_direction = ray.origin_direction;
            copy_ray.distance = ray.distance;
            copy_ray.nRebound = ray.nRebound;
            copy_ray.color = ray.color;
            copy_ray.line_direction = ray.line_direction;
            copy_ray.line_point = point;
            % relfection
            [reflected_ray] = Reflect(problem, ray, normal, point);
            stack = Push(stack, reflected_ray);
            % refraction
            [isTotalReflection refracted_ray] = Refract(problem, copy_ray, normal, point, isEnteringSphere);
            if ~isTotalReflection
                stack = Push(stack, refracted_ray);
            endif
        endif

    end


endfunction
