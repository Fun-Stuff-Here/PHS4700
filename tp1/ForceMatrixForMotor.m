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
