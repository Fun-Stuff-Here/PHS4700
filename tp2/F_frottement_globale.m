function f = F_frottement_globale(context)
    position_fusee = context.r_fusee;
    R = context.rayon_fusee;
    H = context.hauteur_fusee;
    C_vis = context.C_vis;
    vitesse_fusee = context.v_fusee;
    p = rho(position_fusee);

    vz = context.v_fusee(3);
    alpha = acos(vz/norm(context.v_fusee));
    A = pi * R^2  * cos(alpha) + 2 * R * H * sin(alpha);

    f = -1/2 * A * p * C_vis * norm(vitesse_fusee) * vitesse_fusee;
endfunction