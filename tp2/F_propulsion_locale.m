function f = F_propulsion_locale(context)
    % context de la forme {theta: float, mu: float}
    % Theta: angle en radian du propulseur
    % mu: débit massique de l'éjection des gaz. Dans le De2, c'est 1200 ou 0 (s'il n'y a plus de gaz)

% --------------------------- context linking --------------------------- %
    theta = context.theta;
    mu = context.fusee.DEBIT_MASSIQUE_GAZ;
    v_gaz_norme = context.fusee.V_GAZ; % module de la vitesse en m/s
% --------------------------- context linking --------------------------- %

% ---------------------------  computation ------------------------------ %
    v_gaz = v_gaz_norme * [0 sin(theta) cos(theta)]; % en m/s
    f = - mu * v_gaz;
% ---------------------------  computation ------------------------------ %
endfunction
