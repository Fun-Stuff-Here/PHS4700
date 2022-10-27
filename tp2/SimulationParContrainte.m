function [vf t x y z] = SimulationParContrainte(q_0, epsilon, theta)
% SimulationParContrainte simule la trajectoire d'un objet
% avec un contrôle d'erreur et la condition d'arret stopCondition
%   q0        : conditions initiales [q(t0)]
%   epsilon   : vecteur précision pour chaque variable
%   g         : membre de droite de ED. 
%   stopCondition : condition d'arret de la simulation
%   vf     : valeur finale de la vitese
%   t         : vecteur des temps
%   x         : vecteur des positions en x
%   y         : vecteur des positions en y
%   z         : vecteur des positions en z
%  theta      : angle du propulseur

% le nombre de pas de temps et delta t minimum
n_deltaT = 100;
DeltaT = 40;

while(true)
    % -------------------------------Simulation ---------------------------------------------
    % Initialisation
    q_i = q_0;
    t_i = 0;
    t = [t_i];
    x = [0];
    y = [q_0(3)];
    z = [q_0(4)];

    erreurMaximalParDeltaT = epsilon./n_deltaT;

    while (!StopCondition(q_i))
        [q_i m Err]= SEDRK4t0ER(q_i, t_i, t_i + DeltaT, erreurMaximalParDeltaT, 'g', theta);
        t_i = t_i + DeltaT;
        t = [t; t_i];
        x = [x; 0];
        y = [y; q_i(3)];
        z = [z; q_i(4)];
    end

    % -------------------------------Fin Simulation -----------------------------------------

    % calcul erreur comis
    erreur_comis = erreurMaximalParDeltaT .* length(t);
    erreurEstValide = true;
    for i = 1:length(erreur_comis)
        if (erreur_comis(i) > epsilon(i))
            erreurEstValide = false;
        end
    end

    % si erreur comis < epsilon alors on arrete la simulation
    if(erreurEstValide)
        vf = [0; q_i(1); q_i(2)];
        break;
    end

    % sinon on augmente le nombre de pas de temps et diminue delta t
    n_deltaT = 2*length(t) + 1;
    DeltaT = t(end)/n_deltaT;
end

endfunction
