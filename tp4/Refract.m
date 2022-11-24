function [isTotalReflection refracted_ray] = Refract(problem, ray, normal, point, isEnteringSphere)

    refracted_ray = {};
    isTotalReflection = false;

    if isEnteringSphere
        n_i = problem.param.n_ext;
        n_t = problem.param.n_int;
    else
        n_i = problem.param.n_int;
        n_t = problem.param.n_ext;
    end

    i = normal/norm(normal);
    u_i = ray.line_direction/norm(ray.line_direction);

    if n_i > n_t
        if asin(n_t/n_i) < acos(dot(i, u_i))
            isTotalReflection = true;
            return;
        end
    endif


    j = cross(i, u_i)/norm(cross(i, u_i));
    k = cross(i, j);

    s_i = dot(u_i, k);
    s_t = n_i/n_t * s_i;

    u_t = -i*sqrt(1-s_t^2) + k*s_t;

    refracted_ray.line_direction = u_t;
    refracted_ray.line_point = point;
    refracted_ray.color = ray.color;
    refracted_ray.nRebound = ray.nRebound + 1;

endfunction
