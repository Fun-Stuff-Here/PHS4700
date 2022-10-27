function [delta_q] =  g(q, t, theta)
% g:  the function that defines the differential equation
% q:  the state vector
% t:  the time
% theta:  angle propulseur

    terre = {};
    terre.RAYON = 6371 * (10 ^ 3); % En mètres
    terre.MASSE = 5.974 * (10 ^ 24); % En Kg

    fusee = {};
    fusee.MASSE_INITIALE = 320 * (10 ^ 3); % En Kg
    fusee.HAUTEUR = 53; % En mètres
    fusee.RAYON = 1.8; % En mètres
    fusee.V_GAZ = 3.5 * (10 ^ 3); % En mètres / secondes
    fusee.MASSE_CARBURANT_INITIAL = 300 * (10 ^ 3); % En kg
    fusee.POS_PROPULSEUR = [0; 0; -25]; % [x;y;z] en mètres par rapport au CDM de la fusée
    fusee.DEBIT_MASSIQUE_GAZ = 1200; % Kg/s
    fusee.COEFF_TRAINEE = 0.5; % Pas d'unité à ce que je sache;

    context = {};
    context.terre = terre;
    context.fusee = fusee;
    context.theta = theta;
    context.G = 6.673 * (10 ^ -11); % En Nm^2/Kg^2
    context.RHO_0 = 1.275; % Kg/m^3
    context.H_0 = 7200; % mètres
    context.fusee.pos = [0; q(3); q(4)]; % m
    context.fusee.v = [0; q(1); q(2);]; % m/s
    context.fusee.omega = [q(5); 0; 0]; % rad/s
    context.fusee.R = [ q(6); q(7); q(8); q(9)];
    context.fusee.m = q(10); % kg

    % ajuster le DEBIT_MASSIQUE_GAZ s'il n'y a plus de carburant
    if (context.m <= fusee.MASSE_INITIALE - fusee.MASSE_CARBURANT_INITIAL)
        context.fusee.DEBIT_MASSIQUE_GAZ = 0;
    end

    a = Acceleration(context);
    alpha = AccelerationAngulaire(context);
    omega_quat = [0; context.fusee.omega(1); context.fusee.omega(2); context.fusee.omega(3)];
    delta_R = QProduit(context.fusee.R, omega_quat)./2;

    delta_q = [ a(2) % a_y
                a(3) % a_z
                context.fusee.v(2) % v_y
                context.fusee.v(3) % v_z
                alpha(1) % alpha_x
                delta_R(1) % R_1
                delta_R(2) % R_2
                delta_R(3) % R_3
                delta_R(4) % R_4
                context.fusee.DEBIT_MASSIQUE_GAZ % m
    ];

endfunction