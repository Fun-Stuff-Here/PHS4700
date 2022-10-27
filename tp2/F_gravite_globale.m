function f = F_gravite_globale(context)
% F_gravite_globale - Calcul de la force de gravite globale
%    La fonction retourne la force de gravite globale
% context - Structure contenant les variables du contexte

% --------------------------- context linking --------------------------- %
    masse_terre = context.terre.MASSE; % kg
    masse_fusee = context.fusee.m; % kg
    G = context.G;  % Nm²/Kg²
    r_fusee = context.fusee.pos; % m
% --------------------------- context linking --------------------------- %

% ---------------------------  computation ------------------------------ %
    f = (-G * masse_fusee * masse_terre / ( norm(r_fusee.') ^ 3 )) * r_fusee;
% ---------------------------  computation ------------------------------ %
endfunction
