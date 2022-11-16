function a = Acceleration(problem, forces)

% ------------------------------ Problem Definition ---------------------------------
    F_g = forces.F_g;
    F_N = forces.F_N;
    F_f_c = forces.F_f_c;
    F_f_s = forces.F_f_s;
    m = problem.dice.m;
    g = problem.constants.g;
    v_dice = problem.dice.q(4:6);
    position = problem.dice.q(1:3);
    close_enough = problem.hyperparams.close_enough;
    R_min = problem.dice.R_min;
% ------------------------------ Fin Problem Definition -----------------------------
    if (problem.dice.NCollision > problem.hyperparams.max_nCollision_before_rolling) % Si le dice est au sol et glisse
        a = (F_g + F_N + F_f_c + F_f_s)/m;
    else
        a = [0; 0; -g];
    end

endfunction
