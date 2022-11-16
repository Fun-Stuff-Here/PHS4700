function moment_forces = MomentForces(problem, forces)
% MomentForces - Calculates the moment forces of the system
%  Inputs:
%   problem - the problem structure

% ------------------------------ Problem Definition ---------------------------------
    r_CM = problem.dice.q(1:3);
    sommets = CalculSommetsGlobal(problem);
    close_enough = problem.hyperparams.close_enough;
    quaternion_rotation = problem.dice.q(10:13);
    quaternion_rotation = quaternion_rotation/norm(quaternion_rotation);
% ------------------------------ Fin Problem Definition -----------------------------
    positions = {};
    positions.r_f_g = [0; 0; 0];
    positions.r_f_N = [0; 0; 0];
    positions.r_f_f_c = [0; 0; 0];
    positions.r_f_f_s = [0; 0; 0];

% ------------------------------ Find coin qui touche le sol -------------------------
    indexes = sommets(3,:) < close_enough;
    sommets_touching_ground = problem.dice.sommets(:,indexes);
% ------------------------------ Fin Find coin qui touche le sol ---------------------

    if (size(sommets_touching_ground, 2) == 1) % un seul sommet touche le sol
        sommet_quat = [0; sommets_touching_ground(1); sommets_touching_ground(2); sommets_touching_ground(3)];
        positions.r_f_f_c = QRotation(quaternion_rotation, sommet_quat)(2:4);
        positions.r_f_f_s = positions.r_f_f_c;
    elseif (size(sommets_touching_ground, 2) > 1) % edge or face touching ground
        P = [sum(sommets_touching_ground(1,:)); sum(sommets_touching_ground(2,:)); sum(sommets_touching_ground(3,:));]/size(sommets_touching_ground, 2); % P is the center of the edge or face
        P_quat = [0; P(1); P(2); P(3)];
        positions.r_f_f_c = QRotation(quaternion_rotation, P_quat)(2:4);
        positions.r_f_f_s = positions.r_f_f_c;
    end

    positions.r_f_N = FindNormalPosition(problem, forces, positions);

    moment_forces = cross(positions.r_f_N, forces.F_N) + cross(positions.r_f_f_c, forces.F_f_c) + cross(positions.r_f_f_s, forces.F_f_s);
endfunction
