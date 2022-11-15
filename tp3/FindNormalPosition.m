function position = FindNormalPosition(problem, forces, positions)
% Find the position of the normal force
% Input: problem - the problem structure
%        forces - the forces on the body
%        positions - known positions of the forces
% Output: position - the position of the normal force

% ------------------------------ Problem Definition ---------------------------------
    F_g = forces.F_g;
    F_N = forces.F_N;
    F_f_c = forces.F_f_c;
    F_f_s = forces.F_f_s;
    r_f_g = positions.r_f_g;
    r_f_N = positions.r_f_N;
    r_f_f_c = positions.r_f_f_c;
    r_f_f_s = positions.r_f_f_s;
    l = problem.dice.l;
    N_x = F_N(1);
    N_y = F_N(2);
    N_z = F_N(3);
    r_CM = problem.dice.q(1:3);
% ------------------------------ Fin Problem Definition -----------------------------
    other_torque = cross(r_f_g, F_g) + cross(r_f_f_c, F_f_c) + cross(r_f_f_s, F_f_s);
    N_torque = [  0  -N_z  N_y;
                 N_z   0  -N_x;
                -N_y  N_x   0];
    if (norm(other_torque) == 0) % if there is no other torque on the body, normal is parallel to the the center of mass
        position = [0; 0; 0];
        return
    endif
    r_N = r_CM + inv(N_torque) * other_torque;

    groundProjection = ProjectionTouchingGround(problem);
    if (groundProjection.nDims == 0)
% ------------------------------ 0D Projection --------------------------------------
        position = groundProjection.origin - r_CM;
% ------------------------------ Fin 0D Projection ----------------------------------
    elseif (groundProjection.nDims == 1)
% ------------------------------ 1D Projection --------------------------------------
        u_hat = groundProjection.unitVectors(1);
        if (dot(r_N, u_hat) < 0)
            u = 0;
        elseif (dot(r_N, u_hat) > l)
            u = l;
        else
            u = dot(r_N, u_hat);
        endif
        position = groundProjection.origin + u * u_hat - r_CM;
% ------------------------------ End 1D Projection ----------------------------------
    elseif (groundProjection.nDims == 2)
% ------------------------------ 2D Projection --------------------------------------
        u_hat = groundProjection.unitVectors(1);
        v_hat = groundProjection.unitVectors(2);
        if (dot(r_N, u_hat) < 0)
            u = 0;
        elseif (dot(r_N, u_hat) > l)
            u = l;
        else
            u = dot(r_N, u_hat);
        endif
        if (dot(r_N, v_hat) < 0)
            v = 0;
        elseif (dot(r_N, v_hat) > l)
            v = l;
        else
            v = dot(r_N, v_hat);
        endif
        position = groundProjection.origin + u * u_hat + v * v_hat - r_CM;
% ------------------------------ End 2D Projection ----------------------------------
    endif

endfunction
