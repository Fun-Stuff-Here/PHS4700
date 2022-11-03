function [face t x y z sommets] = Devoir3(Pos0, MatR0, V0, W0)
    % Pos0:  [posx posy posz] en mètres
    % MatR0: matrice de rotation à l'intant t0
    % V0: [V0x V0y V0z] en m/s
    % W0 = [W0x W0y W0z] en rad/s

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
