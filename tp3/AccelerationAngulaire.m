function alpha = AccelerationAngulaire(problem, forces)

% ------------------------------ Problem Definition ---------------------------------
    I_inv = problem.dice.I_inv;
    v_dice = problem.dice.q(4:6);
    position = problem.dice.q(1:3);
    close_enough = problem.hyperparams.close_enough;
    R_min = problem.dice.R_min;
% ------------------------------ Fin Problem Definition -----------------------------
    if (problem.dice.NCollision > problem.hyperparams.max_nCollision_before_rolling) % Si le dice est au sol et glisse
        moment_forces = MomentForces(problem, forces);
        alpha = I_inv * moment_forces;
    else
        alpha = [0; 0; 0];
    end
endfunction
