function I = Inertie(masse)
    % Example usage:
    % I = Inertia(100, contexte.fusee);
    rayon = 1.8; % de la fusée, en mètres
    hauteur = 53; % de la fusée, en mètre
    I = masse * ( (rayon^2) / 2 ) + ( (hauteur^2) / 12);
endfunction