function [face t x y z sommets] = Devoir3(Pos0, MatR0, V0, W0)
    % Pos0:  [posx posy posz] en mètres
    % MatR0: matrice de rotation à l'intant t0
    % V0: [V0x V0y V0z] en m/s
    % W0 = [W0x W0y W0z] en rad/s

    % ------------------- Initialisation des variables ----------------
    problem = {};
    % ------------------ Paramètres de la simulation ------------------
    params = {};
    params.Pos0 = Pos0;
    params.MatR0 = MatR0;
    params.V0 = V0;
    params.W0 = W0;
    problem.params = params;
    % ------------------ Fin Paramètres de la simulation --------------
    % ------------------ Constantes physiques -------------------------
    constants = {};
    constants.g = 9.81; % m/s^2
    problem.constants = constants;
    % ------------------ Fin Constantes physiques ---------------------
    % ------------------ Paramètres du cube ---------------------------
    dice = {};
    dice.m = 20e-3; % kg
    dice.mu_c = 0.3; % coefficient de frottement cinétique
    dice.mu_s = 0.5; % coefficient de frottement statique
    dice.epsilon = 0.5; % coefficient de restitution
    dice.l = 4e-2; % m
    dice.a = 4e-2; % m
    dice.b = 4e-2; % m
    dice.c = 4e-2; % m
    dice.I_xx = 1/12*dice.m*(dice.b^2+dice.c^2); % kg.m^2
    dice.I_yy = 1/12*dice.m*(dice.a^2+dice.c^2); % kg.m^2
    dice.I_zz = 1/12*dice.m*(dice.a^2+dice.b^2); % kg.m^2
    dice.I=[dice.I_xx     0        0      ;
                0     dice.I_yy    0      ;
                0         0     dice.I_zz];
    dice.I_inv = inv(dice.I);
    dice.sommets = [%    1          2          3          4         5          6          7          8      %
                     dice.a/2  -dice.a/2  -dice.a/2   dice.a/2  dice.a/2  -dice.a/2  -dice.a/2   dice.a/2  ;
                     dice.b/2   dice.b/2  -dice.b/2  -dice.b/2  dice.b/2   dice.b/2  -dice.b/2  -dice.b/2  ;
                    -dice.c/2  -dice.c/2  -dice.c/2  -dice.c/2  dice.c/2   dice.c/2   dice.c/2   dice.c/2  ];

    % ------------------ Vecteur d'etat q -----------------------------
    R = MatrixToQuat(problem.params.MatR0);
    q = [
        Pos0(1) % x   1
        Pos0(2) % y   2
        Pos0(3) % z   3
        V0(1) % Vx    4
        V0(2) % Vy    5
        V0(3) % Vz    6
        W0(1) % Wx    7
        W0(2) % Wy    8
        W0(3) % Wz    9
        R(1) % quaternion rotation w   10
        R(2) % quaternion rotation x   11
        R(3) % quaternion rotation y   12
        R(4) % quaternion rotation z   13
        ];
    dice.q = q;
    % ------------------ Vecteur d'etat q -----------------------------
    problem.dice = dice;
    % ------------------ Fin Paramètres du cube -----------------------
    % ------------------ Paramètres du sol ----------------------------
    sol = {};
    sol.m = inf; % kg
    sol.z = 0; % m
    sol.v = [0; 0; 0]; % m/s
    sol.I = [ inf  0   0 ;
               0  inf  0 ;
               0   0  inf];
    sol.I_inv = [ 0  0  0 ;
                  0  0  0 ;
                  0  0  0];
    sol.n_hat = [0; 0; 1]; % vecteur normal au sol (pointant vers le dice)
    problem.sol = sol;
    % ------------------ Fin Paramètres du sol ------------------------

    % ------------------ HyperParamètres de la simulation -------------
    hyperparams = {};
    hyperparams.facteur_erreur_collision = 1; % factor by which the erreur is divided when a collision occurs
    hyperparams.facteur_delta_t = 100; % factor by which the time step is divided when a collision occurs
    problem.hyperparams = hyperparams;
    % ------------------ Fin HyperParamètres de la simulation ---------
    % ------------------ Fin Initialisation des variables -------------


    [t x y z all_sommets] = Simulation(problem);

    face = CalculFaceObtenue(problem);
    sommets = all_sommets(end); % Position finale de chaun des 8 sommets


    % ------------------ Affichage des résultats ----------------------
    % // first plot out of loop (to get plot handle)
    figure;
    sommets_plot = all_sommets{1};
    x_plot = [sommets_plot(1,:)];
    y_plot = [sommets_plot(2,:)];
    z_plot = [sommets_plot(3,:)];
    % ------------------  Affichage du cube ---------------------------
    plot3(x_plot([1,2]), y_plot([1,2]), z_plot([1,2]), 'k');
    hold on;
    plot3(x_plot([1,4]), y_plot([1,4]), z_plot([1,4]), 'k');
    hold on;
    plot3(x_plot([3,4]), y_plot([3,4]), z_plot([3,4]), 'k');
    hold on;
    plot3(x_plot([2,3]), y_plot([2,3]), z_plot([2,3]), 'k');
    hold on;
    plot3(x_plot([1,5]), y_plot([1,5]), z_plot([1,5]), 'k');
    hold on;
    plot3(x_plot([2,6]), y_plot([2,6]), z_plot([2,6]), 'k');
    hold on;
    plot3(x_plot([3,7]), y_plot([3,7]), z_plot([3,7]), 'k');
    hold on;
    plot3(x_plot([4,8]), y_plot([4,8]), z_plot([4,8]), 'k');
    hold on;
    plot3(x_plot([5,6]), y_plot([5,6]), z_plot([5,6]), 'k');
    hold on;
    plot3(x_plot([6,7]), y_plot([6,7]), z_plot([6,7]), 'k');
    hold on;
    plot3(x_plot([7,8]), y_plot([7,8]), z_plot([7,8]), 'k');
    hold on;
    plot3(x_plot([5,8]), y_plot([5,8]), z_plot([5,8]), 'k');
    hold on;
    % ------------------  Fin Affichage du cube -----------------------
    % ------------------  Affichage du sol ----------------------------
    scale = max([max(x) max(y)])+0.1;
    plot3([scale, scale, -scale, -scale, scale], [scale, -scale, -scale, scale, scale], [0, 0, 0, 0, 0], 'k');
    zlim([0, max(z)+0.1]);
    hold on;
    % ------------------  Fin Affichage du sol ------------------------

    axis("equal");
    xlabel('x')
    ylabel('y')
    zlabel('z')
    title(['t = ' num2str(t(1))]);
    hold on;
    pause(1);

    for i = 1:7:size(t, 2)

        sommets_plot = all_sommets{i};
        x_plot = [sommets_plot(1,:)];
        y_plot = [sommets_plot(2,:)];
        z_plot = [sommets_plot(3,:)];

        % ------------------  Affichage du cube ---------------------------
        plot3(x_plot([1,2]), y_plot([1,2]), z_plot([1,2]), 'k');
        hold on;
        plot3(x_plot([1,4]), y_plot([1,4]), z_plot([1,4]), 'k');
        hold on;
        plot3(x_plot([3,4]), y_plot([3,4]), z_plot([3,4]), 'k');
        hold on;
        plot3(x_plot([2,3]), y_plot([2,3]), z_plot([2,3]), 'k');
        hold on;
        plot3(x_plot([1,5]), y_plot([1,5]), z_plot([1,5]), 'k');
        hold on;
        plot3(x_plot([2,6]), y_plot([2,6]), z_plot([2,6]), 'k');
        hold on;
        plot3(x_plot([3,7]), y_plot([3,7]), z_plot([3,7]), 'k');
        hold on;
        plot3(x_plot([4,8]), y_plot([4,8]), z_plot([4,8]), 'k');
        hold on;
        plot3(x_plot([5,6]), y_plot([5,6]), z_plot([5,6]), 'k');
        hold on;
        plot3(x_plot([6,7]), y_plot([6,7]), z_plot([6,7]), 'k');
        hold on;
        plot3(x_plot([7,8]), y_plot([7,8]), z_plot([7,8]), 'k');
        hold on;
        plot3(x_plot([5,8]), y_plot([5,8]), z_plot([5,8]), 'k');
        axis("equal");hold on;
        title(['t = ' num2str(t(i))]);
        % ------------------  Fin Affichage du cube -----------------------

        pause(0.5); %// update plot
    end
    pause(30);
    % ------------------ Fin Affichage des résultats ------------------
endfunction
