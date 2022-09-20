function R_i = PositionMoteurMatrix(context)

    %calcul des vecteur positions a partir du centre de masse
    r_1 = [ context.R_axes_moteur;
            0;
            0]; % vecteur position du moteur M1 par rapport a l'origine du referenciel Drone
    r_2 = [ context.R_axes_moteur*cos(context.theta_b);
            context.R_axes_moteur*sin(context.theta_b);
            0]; % vecteur position du moteur M2 par rapport a l'origine du referenciel Drone
    r_3 = [ -context.R_axes_moteur*cos(context.theta_b);
            context.R_axes_moteur*sin(context.theta_b);
            0]; % vecteur position du moteur M3 par rapport a l'origine du referenciel Drone
    r_4 = [ -context.R_axes_moteur;
            0;
            0]; % vecteur position du moteur M4 par rapport a l'origine du referenciel Drone
    r_5 = [ -context.R_axes_moteur*cos(context.theta_b);
            -context.R_axes_moteur*sin(context.theta_b);
            0]; % vecteur position du moteur M5 par rapport a l'origine du referenciel Drone
    r_6 = [ context.R_axes_moteur*cos(context.theta_b);
            -context.R_axes_moteur*sin(context.theta_b);
            0]; % vecteur position du moteur M6 par rapport a l'origine du referenciel Drone

    R_i = [r_1 r_2 r_3 r_4 r_5 r_6] - context.cdm_local; % vecteur position des moteurs par rapport au centre de masse du referenciel Drone

endfunction
