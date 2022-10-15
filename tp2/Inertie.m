function I = Inertie(masse, contextFusee)
    % Example usage:
    % I = Inertia(100, contexte.fusee);
    I = masse * ( (contextFusee.RAYON^2) / 2 ) + ( (contextFusee.HAUTEUR^2) / 12);
endfunction