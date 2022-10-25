function [delta_q] =  g(q, t)
    terre = {};
    terre.RAYON = 6371 * (10 ^ 3); % En mètres
    terre.MASSE = 5.974 * (10 ^ 24); % En Kg

    fusee = {};
    fusee.MASSE_INITIALE = 320 * (10 ^ 3); % En Kg
    fusee.HAUTEUR = 53; % En mètres
    fusee.RAYON = 1.8; % En mètres
    fusee.V_GAZ = 3.5 * (10 ^ 3); % En mètres / secondes
    fusee.MASSE_CARBURANT_INITIAL = 270 * (10 ^ 3); % En kg
    fusee.POS_PROPULSEUR = [0; 0; -25]; % [x;y;z] en mètres par rapport au CDM de la fusée
    fusee.DEBIT_MASSIQUE_GAZ = 1200; % Kg/s
    fusee.COEFF_TRAINEE = 0.5; % Pas d'unité à ce que je sache;

    contexte = {};
    contexte.terre = terre;
    contexte.fusee = fusee;
    contexte.G = 6.673 * (10 ^ -11); % En Nm^2/Kg^2
    contexte.RHO_0 = 1.275; % Kg/m^3
    contexte.H_0 = 7200; % mètres
    contexte.pos = [0; q(3); q(4)]; % m
    contexte.v = [0; q(1); q(2);]; % m/s
    contexte.omega = [q(5); 0; 0]; % rad/s
    contexte.R = [ q(6); q(7); q(8); q(9)];
    contexte.m = q(10); % kg

    a = Acceleration(contexte);
    alpha = AccelerationAngulaire(contexte);
    delta_R = [ (-contexte.R(2) * contexte.omega(1)) /2;
                ( contexte.R(1) * contexte.omega(1)) /2;
                ( contexte.R(4) * contexte.omega(1)) /2;
                (-contexte.R(3) * contexte.omega(1)) /2;
    ];

    delta_m = 0;
    if (contexte.m > fusee.MASSE_INITIALE - fusee.MASSE_CARBURANT_INITIAL)
        delta_m = -fusee.DEBIT_MASSIQUE_GAZ;
    end

    delta_q = [ a(2) % a_y
                a(3) % a_z
                contexte.v(2) % v_y
                contexte.v(3) % v_z
                alpha(1) % alpha_x
                delta_R(1) % R_1
                delta_R(2) % R_2
                delta_R(3) % R_3
                delta_R(4) % R_4
                delta_m % m
    ];

endfunction