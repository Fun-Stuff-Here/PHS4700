function f = F_frottement_globale(context)
% Force de frottement globale
% context : structure contenant les variables du contexte

% --------------------------- context linking --------------------------- %
    position_fusee = context.fusee.pos; % m
    R = context.fusee.RAYON; % m
    H = context.fusee.HAUTEUR; % m
    C_vis = context.fusee.COEFF_TRAINEE;
    vitesse_fusee = context.fusee.v; % m/s
% --------------------------- context linking --------------------------- %

% -------------------------- function linking --------------------------- %
    p = rho(position_fusee);
% -------------------------- function linking --------------------------- %

% ---------------------------  computation ------------------------------ %
    vz = vitesse_fusee(3);
    alpha = acos(vz/norm(vitesse_fusee));
    A = pi * R^2  * cos(alpha) + 2 * R * H * sin(alpha);

    f = -1/2 * A * p * C_vis * norm(vitesse_fusee) * vitesse_fusee;
% ---------------------------  computation ------------------------------ %
endfunction
