function f = F_propulsion_locale(context)
    % context de la forme {theta: float, mu: float}
    % Theta: angle en radian du propulseur
    % mu: débit massique de l'éjection des gaz. Dans le De2, c'est 1200 ou 0 (s'il n'y a plus de gaz)

    context = {};
    context.theta = 0.2;
    context.mu = 1200;

    v_gaz = [0 sin(context.theta) cos(context.theta)]; % en m/s
    f = - context.mu * v_gaz;
endfunction

context = {};
context.mu = 1200;
context.theta = 0.2;
x = F_propulsion_locale(context);
fprintf(x);
