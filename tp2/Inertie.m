function I = Inertie(context)
% I matrice d'inertie de la fusee
% context : structure contenant les parametres de la simulation

% --------------------------- context linking --------------------------- %
    r = context.fusee.RAYON; 
    l = context.fusee.HAUTEUR;
    m = context.fusee.m; % masse en kg
% --------------------------- context linking --------------------------- %

% ---------------------------  computation ------------------------------ %
    I_xx = m/4 *r^2 + m/12 *l^2;
    I_yy = m/4 *r^2 + m/12 *l^2;
    I_zz = m/2 *r^2;

    I = [   I_xx 0      0  ;
            0    I_yy   0  ;
            0     0   I_zz];
% ---------------------------  computation ------------------------------ %

endfunction
