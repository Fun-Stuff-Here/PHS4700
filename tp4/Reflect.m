function [reflected_ray] = Reflect(ray, normal, point)

    i = normal/norm(normal);
    u_i = ray.line_direction/norm(ray.line_direction);

    j = cross(i, u_i)/norm(cross(i, u_i));
    k = cross(i, j);

    s_i = dot(k, u_i);
    u_r = i*sqrt(1-s_i^2) + k*s_i;

    reflected_ray = {};
    reflected_ray.line_direction = u_r;
    reflected_ray.line_point = point;
    reflected_ray.color = ray.color;
    reflected_ray.nRebound = ray.nRebound + 1;

endfunction
