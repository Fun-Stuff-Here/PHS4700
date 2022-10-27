function f = F_frottement_globale(context)
% Force de frottement globale
% context : structure contenant les variables du contexte

% --------------------------- context linking --------------------------- %
    position_fusee = context.fusee.pos; % m
    R = context.fusee.RAYON; % m
    H = context.fusee.HAUTEUR; % m
    C_vis = context.fusee.COEFF_TRAINEE;
    vitesse_fusee = context.fusee.v; % m/s
    q_rotation = context.fusee.R;
% --------------------------- context linking --------------------------- %

% -------------------------- function linking --------------------------- %
    p = rho(context);
% -------------------------- function linking --------------------------- %

% ---------------------------  computation ------------------------------ %
    u_z_quat = [0; 0; 0; 1]; % vecteur unitaire de la direction z
    u_z_globale = (QRotation(q_rotation.', u_z_quat.')(2:4)).';
    alpha = acos(dot(u_z_globale.', vitesse_fusee.')/(norm(vitesse_fusee.')*norm(u_z_globale.')));
    % gere la situation ou la vitesse est nulle
    if isnan(alpha)
        alpha = 0;
    end

    A = pi * R^2  * cos(alpha) + 2 * R * H * sin(alpha);

    f = -1/2 * A * p * C_vis * norm(vitesse_fusee.') * vitesse_fusee;
% ---------------------------  computation ------------------------------ %
endfunction
