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
    dice.l = 15e-2; % m
    dice.a = 15e-2; % m
    dice.b =15e-2; % m
    dice.c = 15e-2; % m
    dice.I_xx = 1/12*dice.m*(dice.b^2+dice.c^2); % kg.m^2
    dice.I_yy = 1/12*dice.m*(dice.a^2+dice.c^2); % kg.m^2
    dice.I_zz = 1/12*dice.m*(dice.a^2+dice.b^2); % kg.m^2
    dice.I=[dice.I_xx     0        0      ;
                0     dice.I_yy    0      ;
                0         0     dice.I_zz];
    dice.I_inv = inv(dice.I);
    dice.vertex = [%    1          2          3          4         5          6          7          8      %
                     dice.a/2  -dice.a/2  -dice.a/2   dice.a/2  dice.a/2  -dice.a/2  -dice.a/2   dice.a/2  ;
                     dice.b/2   dice.b/2  -dice.b/2  -dice.b/2  dice.b/2   dice.b/2  -dice.b/2  -dice.b/2  ;
                    -dice.c/2   dice.c/2  -dice.c/2  -dice.c/2  dice.c/2   dice.c/2   dice.c/2   dice.c/2  ];
    dice.faces = {};
    dice.faces.face_1 = [dice.vertex(:,5) dice.vertex(:,6) dice.vertex(:,7) dice.vertex(:,8)]; % vertex de la face 1
    dice.faces.face_2 = [dice.vertex(:,3) dice.vertex(:,4) dice.vertex(:,7) dice.vertex(:,8)]; % vertex de la face 2
    dice.faces.face_3 = [dice.vertex(:,2) dice.vertex(:,3) dice.vertex(:,6) dice.vertex(:,7)]; % vertex de la face 3
    dice.faces.face_4 = [dice.vertex(:,1) dice.vertex(:,4) dice.vertex(:,5) dice.vertex(:,8)]; % vertex de la face 4
    dice.faces.face_5 = [dice.vertex(:,1) dice.vertex(:,2) dice.vertex(:,5) dice.vertex(:,6)]; % vertex de la face 5
    dice.faces.face_6 = [dice.vertex(:,5) dice.vertex(:,6) dice.vertex(:,7) dice.vertex(:,8)]; % vertex de la face 6

    % ------------------ Vecteur d'etat q -----------------------------
    R = MatrixToQuat(problem.params.MatR0);
    q = [
        Pos0(1) % x
        Pos0(2) % y
        Pos0(3) % z
        V0(1) % Vx
        V0(2) % Vy
        V0(3) % Vz
        W0(1) % Wx
        W0(2) % Wy
        W0(3) % Wz
        R(1) % quaternion rotation w
        R(2) % quaternion rotation x
        R(3) % quaternion rotation y
        R(4) % quaternion rotation z
        ];
    dice.q = q;
    % ------------------ Vecteur d'etat q -----------------------------
    problem.dice = dice;
    % ------------------ Fin Paramètres du cube -----------------------
    % ------------------ Fin Initialisation des variables -------------




    face = 1; % TODO Donne la face du résultat
    t = [1 2 3 4]; % vecteur contenant le temps correspondant à chacune des positions enregistrées pour le tracé la trajectoire du dé. La dernière valeur doit être l’instant d’arrêt de la simulation 
    x = [1 2 3 4]; 
    y = [1 2 3 4];
    z = [1 2 3 4];
    sommets = [
        1 2 3;
        4 5 6;
        7 8 9;
        1 2 3;
        4 5 6;
        7 8 9;
        1 2 3;
        4 5 6;
        ]; % Position finale de chaun des 8 sommets

endfunction
