function f = F_propulsion_locale(context)
    % context de la forme {theta: float, mu: float}
    % Theta: angle en radian du propulseur
    % mu: débit massique de l'éjection des gaz. Dans le De2, c'est 1200 ou 0 (s'il n'y a plus de gaz)

    context = {};
    context.theta = 0.2;
    context.mu = 1200;
    context.v_gaz = 3.5 * 10 ^ 3 ; % module de la vitesse en m/x

    v_gaz = context.v_gaz * [0 sin(context.theta) cos(context.theta)]; % en m/s
    f = - context.mu * v_gaz;
endfunction



