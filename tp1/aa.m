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

function F_i = ForceMatrixForMotor(context)
        %calcul des vecteur forces
        F_1 = [ 0;
                0;
                context.F_max * context.Lambda(1)]; % vecteur force du moteur M1 par rapport a l'origine du referenciel Drone
        F_2 = [ 0;
                0;
                context.F_max * context.Lambda(2)]; % vecteur force du moteur M2 par rapport a l'origine du referenciel Drone
        F_3 = [ 0;
                0;
                context.F_max * context.Lambda(3)]; % vecteur force du moteur M3 par rapport a l'origine du referenciel Drone
        F_4 = [ 0;
                0;
                context.F_max * context.Lambda(4)]; % vecteur force du moteur M4 par rapport a l'origine du referenciel Drone
        F_5 = [ 0;
                0;
                context.F_max * context.Lambda(5)]; % vecteur force du moteur M5 par rapport a l'origine du referenciel Drone
        F_6 = [ 0;
                0;
                context.F_max * context.Lambda(6)]; % vecteur force du moteur M6 par rapport a l'origine du referenciel Drone

        F_i = [F_1 F_2 F_3 F_4 F_5 F_6]; % vecteur force des moteurs par rapport a l'origine du referenciel Drone
endfunction

function t_cm = MomentForceAuCentreDeMasse(R_i, F_i)
    %Calcul du moment de force au centre de masse
     t_cm = zeros(1,3);
     for i = 1:size(R_i,2)
         t_cm += cross(R_i(:,i), F_i(:,i));
    endfor
endfunction

function aaOut = aa(context)

    R_i = PositionMoteurMatrix(context);
    F_i = ForceMatrixForMotor(context);
    t_cm = MomentForceAuCentreDeMasse(R_i, F_i);
    L = context.MI * context.va;

    aaOut = inv(context.MI) * (t_cm + cross(L, context.va));
endfunction
