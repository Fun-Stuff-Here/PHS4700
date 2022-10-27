function p = rho(context)
% RHO  Compute the density of the atmosphere at a given altitude
% context structure des variables de l'environnement

% --------------------------- context linking --------------------------- %
    position_fusee = context.fusee.pos; % m
    rho_o = context.RHO_0; % kg/m^3
    H_0 = context.H_0; % m
    R_t = context.terre.RAYON; % m
% --------------------------- context linking --------------------------- %

% ---------------------------  computation ------------------------------ %
    norme_position = norm(position_fusee.');
    p = rho_o * exp( (R_t - norme_position)/H_0 );
% ---------------------------  computation ------------------------------ %
endfunction
