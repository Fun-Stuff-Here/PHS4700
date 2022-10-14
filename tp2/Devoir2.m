function [Vf t x y z] = Devoir2(theta)

    terre = {};
    terre.RAYON = 6371 * (10 ** 3); % En mètres
    terre.MASSE = 5.974 * (10 ** 24); % En Kg

    G = 6.673 * (10 ** -11); % En Nm^2/Kg^2
    RHO_0 = 1.275; % Kg/m^3
    H_0 = 7200; % mètres

    fusee = {};
    fusee.MASSE_INITIALE = 320 * (10 ** 3); % En Kg
    fusee.HAUTEUR = 53; % En mètres
    fusee.RAYON = 1.8; % En mètres
    fusee.V_GAZ = 3.5 * (10 ** 3); % En mètres / secondes
    fusee.MASSE_CARBURANT_INITIAL = 270 * (10 ** 3); % En kg
    fusee.POS_PROPULSEUR = [0; 0;-25]; % [x;y;z] en mètres par rapport au CDM de la fusée
    fusee.DEBIT_MASSIQUE_GAZ = 1200; % Kg/s
    fusee.COEFF_TRAINEE = 0.5; % Pas d'unité à ce que je sache;


    % TODO Mettre des valeurs pas Bidons à ces valeurs
    epsilon = [ inf; % erreur sur v_y
                inf; % erreur sur v_z
                10; % erreur sur y
                10; % erreur sur z
                inf; % erreur sur w_x
                inf; % erreur sur R_1
                inf; % erreur sur R_2
                inf; % erreur sur R_3
                inf; % erreur sur R_4
                inf; % erreur sur m
];

    [Vf t x y z] = SimulationParContrainte(q_0, epsilon, stopCondition)

endfunction