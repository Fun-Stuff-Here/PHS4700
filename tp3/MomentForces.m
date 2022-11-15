function moment_forces = MomentForces(problem, forces)
% MomentForces - Calculates the moment forces of the system
%  Inputs:
%   problem - the problem structure

% ------------------------------ Problem Definition ---------------------------------
    r_CM = problem.dice.q(1:3);
    sommets = CalculSommetsGlobal(problem);
    close_enough = problem.hyperparams.close_enough;
% ------------------------------ Fin Problem Definition -----------------------------
    positions = {};
    positions.r_f_g = [0; 0; 0];
    positions.r_f_N = [0; 0; 0];
    positions.r_f_f_c = [0; 0; 0];
    positions.r_f_f_s = [0; 0; 0];

% ------------------------------ Find coin qui touche le sol -------------------------
    indexes = sommets(3,:) < close_enough;
    sommets_touching_ground = sommets(:,indexes);
% ------------------------------ Fin Find coin qui touche le sol ---------------------

    if (size(sommets_touching_ground, 2) < 2) % un seul sommet touche le sol
        positions.r_F_f_c = sommets_touching_ground - r_CM;
        positions.r_F_f_s = sommets_touching_ground - r_CM;
    else % edge or face touching ground
        P = [sum(cornersInColision(1,:)); sum(cornersInColision(2,:)); sum(cornersInColision(3,:));]/size(cornersInColision, 2); % P is the center of the edge or face
        positions.r_F_f_c = P - r_CM;
        positions.r_F_f_s = P - r_CM;
    end

    positions.r_f_N = FindNormalPosition(problem, forces, positions);

    moment_forces = cross(positions.r_f_N, forces.F_N) + cross(positions.r_f_f_c, forces.F_f_c) + cross(positions.r_f_f_s, forces.F_f_s);

endfunction
