function [xi, yi, zi, face] = Devoir4(Robs, nint, next)

    problem = {};
% ---------------------------------Param ----------------------------------%
    param = {};
    param.R_obs = Robs;
    param.n_int = nint;
    param.n_ext = next;
    problem.param = param;
% ---------------------------------Param ----------------------------------%
% ---------------------------------Color ----------------------------------%
    color = {};
    color.cyan = 1;
    color.blue = 2;
    color.orange = 3;
    color.red = 4;
    color.magenta = 5;
    color.green = 6;
    problem.color = color;
% ---------------------------------Color ----------------------------------%
% -------------------------------Box---------------------------------------%
    box = {};
    box.a = 4e-2; % m
    box.b = 2e-2; % m
    box.c = 4e-2; % m
    box.pos = [0; 2e-2; 0] % m

    problem.box = box;
% -------------------------------Box---------------------------------------%
% ---------------------------------Planes ---------------------------------%
    plane_1 = {};
    plane_1.color = color.cyan;
    plane_1.plane_normal = [1; 0; 0];
    plane_1.plane_distance = -box.a/2;

    plane_2 = {};
    plane_2.color = color.blue;
    plane_2.plane_normal = [1; 0; 0];
    plane_2.plane_distance = box.a/2;

    plane_3 = {};
    plane_3.color = color.orange;
    plane_3.plane_normal = [0; 1; 0];
    plane_3.plane_distance = -box.b/2;

    plane_4 = {};
    plane_4.color = color.red;
    plane_4.plane_normal = [0; 1; 0];
    plane_4.plane_distance = box.b/2;

    plane_5 = {};
    plane_5.color = color.magenta;
    plane_5.plane_normal = [0; 0; 1];
    plane_5.plane_distance = 0;

    plane_6 = {};
    plane_6.color = color.green;
    plane_6.plane_normal = [0; 0; 1];
    plane_6.plane_distance = box.c;

    planes = {plane_1, plane_2, plane_3, plane_4, plane_5, plane_6};
    problem.planes = planes;
% ---------------------------------Planes ---------------------------------%
% -------------------------------Sphere------------------------------------%
    sphere = {};
    sphere.R = 8e-2; % m
    sphere.pos = [0; 0; 0]; % m
    problem.sphere = sphere;
% -------------------------------Sphere------------------------------------%
% -------------------------------hyperParam--------------------------------%
    hyperParam = {};
    hyperParam.n_rayon_minimum = 1000;
    hyperParam.debugMode = true;
    hyperParam.epsilon = 1e-6;
    hyperParam.ndim = 3;
    problem.hyperParam = hyperParam;
% -------------------------------hyperParam--------------------------------%

endfunction
