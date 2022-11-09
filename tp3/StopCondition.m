function [isConditionMet, E] = StopCondition(problem, q)
% StopCondition - Check if the stopping condition is met
% On input:
%     problem (Problem): problem structure
%     q (Problem): current state
% On output:
%     isConditionMet (Boolean): 1 if stopping condition is met, 0 otherwise
% Call:
%     [isConditionMet] = StopCondition(problem, q);

    % -------- Linking the problem structure to the local variables ------
    v = problem.dice.q(4:6);
    v_x = v(1);
    v_y = v(2);
    v_z = v(3);
    omega = problem.dice.q(7:9);
    omage_x = omega(1);
    omage_y = omega(2);
    omage_z = omega(3);
    g = problem.constants.g;
    m = problem.dice.m;
    I = problem.dice.I;
    I_xx = I(1,1);
    I_yy = I(2,2);
    I_zz = I(3,3);
    z = problem.dice.q(3);
    l = problem.dice.l;
    % -------- Fin Linking the problem structure to the local variables --

    % ------------------ Calcul ernergie ---------------------------------

    E =1/2*m*dot(v,v) + 1/2 * I(1,1) * dot(omega, omega) + m * g * z;
    % ------------------ Fin Calcul ernergie -----------------------------

    isConditionMet = (E < sqrt(2) * m * g * l);

endfunction
