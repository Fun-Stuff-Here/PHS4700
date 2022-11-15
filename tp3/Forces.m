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
    omega = problem.dice.q(7:9);
    v_sol = problem.sol.v;
    mu_c = problem.dice.mu_c;
    mu_s = problem.dice.mu_s;
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
        sommets_global = CalculSommetsGlobal(problem);
        indexes = sommets_global(3,:) < close_enough;
        sommets = sommets_global(:, indexes);
        if (size(sommets, 2) > 1)
            sommet = [sum(sommets(1,:)); sum(sommets(2,:)); sum(sommets(3,:))]/size(sommets,2);
        elseif (size(sommets, 2) == 0)
            sommet = [inf; inf; inf];
        else
            sommet = sommets(:,1);
        endif
        v_r = dot(v_dice + cross(omega, sommet), n_hat);
        if (debugMode)
            printf(" v_r = %f ,sommets = 1:%f,2:%f,3:%f,4:%f,5:%f,6:%f,7:%f,8:%f \n", v_r, sommets_global(3,1), sommets_global(3,2), sommets_global(3,3), sommets_global(3,4), sommets_global(3,5), sommets_global(3,6), sommets_global(3,7), sommets_global(3,8));
        endif

        if (abs(v_r) < close_enough)
% ----------------------------- Normale ----------------------------------------------
            F_N = -F_g;
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
            v_r = v_dice - v_sol;
            v_r_perpendiculaire = dot(v_r, n_hat) * n_hat;
            v_r_parallele = v_r - v_r_perpendiculaire;
            if (norm(v_r_parallele) > 0)
                F_f_c = -mu_c * F_N * (v_r_parallele/norm(v_r_parallele));
            else
                F_f_c = [0; 0; 0];
            end
            forces.F_f_c = F_f_c;
% ----------------------------- Fin Frottements cinetique ----------------------------
        endif
    end
endfunction
