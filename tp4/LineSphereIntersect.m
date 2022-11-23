function [doesIntersect ti intersection_points] = LineSphereIntersect(problem, line)

    R = problem.sphere.R;
    p = line.line_point;
    x_0 = p(1);
    y_0 = p(2);
    z_0 = p(3);
    u = line.line_direction;
    u_x = u(1);
    u_y = u(2);
    u_z = u(3);

    a = x_0^2 + y_0^2 + z_0^2 - R^2;
    b = 2*(x_0*u_x + y_0*u_y + z_0*u_z);
    c = u_x^2 + u_y^2 + u_z^2;

    discriminant = b^2 - 4*a*c;

    if discriminant < 0
        doesIntersect = false;
        ti = [];
        intersection_points = [];
        return
    endif

    if discriminant == 0
        doesIntersect = true;
        ti = [(-b)/(2*a)];
        intersection_points = [p + ti(1)*u];
        return
    endif

    if discriminant > 0
        doesIntersect = true;
        ti = [(-b + sqrt(discriminant))/(2*a), (-b - sqrt(discriminant))/(2*a)];
        intersection_points = [p + ti(1)*u; p + ti(2)*u];
        return
    endif

endfunction