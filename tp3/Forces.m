function forces = Forces(problem)
% Forces - Compute the forces acting on the system
%   forces = Forces(problem) computes the forces acting on the system
%   problem contains all the information about the system
%   forces is a structure containing the forces acting on the system and the position of the forces

% ------------------------------ Problem Definition ---------------------------------
    m = problem.dice.m;
    g = problem.constants.g;
    n_hat = problem.sol.n_hat;
    v_dice = problem.dice.q(4:6);
    position = problem.dice.q(1:3);
    r_CM = problem.dice.q(1:3);
    omega = problem.dice.q(7:9);
    quaternion_rotation = problem.dice.q(10:13);
    quaternion_rotation = quaternion_rotation/norm(quaternion_rotation);
    v_sol = problem.sol.v;
    mu_c = problem.dice.mu_c;
    mu_s = problem.dice.mu_s;
    sommets = CalculSommetsGlobal(problem);
    R_min = problem.dice.R_min;
    n_hat = problem.sol.n_hat;
    close_enough = problem.hyperparams.close_enough;
    debugMode = problem.hyperparams.debugMode;
% ------------------------------ Fin Problem Definition ------------------------------
    forces = {};
    forces.F_g = [0; 0; 0];
    forces.F_N = [0; 0; 0];
    forces.F_f_c = [0; 0; 0];
    forces.F_f_s = [0; 0; 0];
% ----------------------------- Gravite ----------------------------------------------
    F_g = m * g * -n_hat;
    forces.F_g = F_g;
% ----------------------------- Fin Gravite ------------------------------------------

    if (abs(position(3)) < R_min + close_enough) % Si le dice est au sol et glisse
        if (problem.dice.NCollision > problem.hyperparams.max_nCollision_before_rolling)
% ------------------------------ Find coin qui touche le sol -------------------------
            indexes = sommets(3,:) < close_enough;
            sommets_touching_ground = problem.dice.sommets(:,indexes);
% ------------------------------ Fin Find coin qui touche le sol ---------------------
% ----------------------------- Normale ----------------------------------------------
            if (size(sommets_touching_ground, 2) < 1)
                F_N = [0; 0; 0];
            else
                F_N = -F_g;
            endif
            forces.F_N = F_N;
% ----------------------------- Fin Normale ------------------------------------------
% ----------------------------- Frottements statique ---------------------------------
            F_perpendiculaire = dot(F_g, n_hat) * n_hat;
            F_parallele = F_g - F_perpendiculaire;
            F_s_max = -mu_s * norm(F_perpendiculaire) * (F_parallele/norm(F_parallele));
            if (norm(F_parallele) <= norm(F_s_max))
                F_f_s = -F_parallele;
            else
                F_f_s = [0; 0; 0];
            end
            forces.F_f_s = F_f_s;
% ----------------------------- Fin Frottements statique -----------------------------
% ----------------------------- Frottements cinetique --------------------------------
            if (size(sommets_touching_ground, 2) == 1) % un seul sommet touche le sol
                sommet_quat = [0; sommets_touching_ground(1); sommets_touching_ground(2); sommets_touching_ground(3)];
                r_F_f_c = QRotation(quaternion_rotation, sommet_quat)(2:4);
            elseif (size(sommets_touching_ground, 2) > 1) % edge or face touching ground
                P = [sum(sommets_touching_ground(1,:)); sum(sommets_touching_ground(2,:)); sum(sommets_touching_ground(3,:));]/size(sommets_touching_ground, 2) - r_CM; % P is the center of the edge or face
                P_quat = [0; P(1); P(2); P(3)];
                r_F_f_c = QRotation(quaternion_rotation, P_quat)(2:4);
            else
                r_F_f_c = [0; 0; 0];
            endif
            v_r = (v_dice - v_sol) + cross(omega, r_F_f_c);
            if (size(sommets_touching_ground, 2) < 1)
                v_r = [0; 0; 0];
            endif
            v_r_perpendiculaire = dot(v_r, n_hat) * n_hat;
            v_r_parallele = v_r - v_r_perpendiculaire;
            if (norm(v_r_parallele) > 0)
                F_f_c = -mu_c * dot(F_N, n_hat) * (v_r_parallele/norm(v_r_parallele));
            else
                F_f_c = [0; 0; 0];
            end
            forces.F_f_c = F_f_c;
% ----------------------------- Fin Frottements cinetique ----------------------------
        endif
    end
endfunction
