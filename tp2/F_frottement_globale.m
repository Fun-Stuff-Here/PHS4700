function f = F_frottement_globale(context)
    position_fusee = (6371*(10^3) + 0.1 * (10^3)) * [0 1 0]; % 100m d'altitude en y
    R = 10;
    H = 50;
    C_vis = 0.5;
    vitesse_fusee = [4 5 6];
    p = rho(position_fusee);
    alpha = 1
    A = pi * R^2  * cos(alpha) + 2 * R * H * sin(alpha);

    f = -1/2 * A * p * C_vis * norm(vitesse_fusee) * vitesse_fusee;
endfunction