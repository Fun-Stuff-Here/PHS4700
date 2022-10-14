function [vf t x y z] = SimulationParContrainte(q_0, epsilon, stopCondition, g)
% SimulationParContrainte simule la trajectoire d'un objet
% avec un contrôle d'erreur et la condition d'arret stopCondition
%   q0        : conditions initiales [q(t0)]
%   epsilon   : vecteur précision pour chaque variable
%   g         : membre de droite de ED. 
%  stopCondition : condition d'arret de la simulation
%   vf_y      : valeur finale de la vitese en y
%   vf_z      : valeur finale de la vitese en z
%   t         : vecteur des temps
%   y         : vecteur des positions en y
%   z         : vecteur des positions en z

DeltaT = 0.01;
n_deltaT = 100;

while(true)
    % -------------------------------Simulation ---------------------------------------------
    % Initialisation
    q_i = q_0;
    t_i = 0;
    t = t_i;
    x = [0];
    y = [q(3)];
    z = [q(4)];

    erreurMaximalParDeltaT = epsilon./DeltaT;

    while (!stopCondition(q_i))
        [q_i m Err]= SEDRK4t0ER(q_i, t_i, t_i+DeltaT, erreurMaximalParDeltaT, g);
        t = [t; t_i];
        x = [x; 0];
        y = [y; q_i(3)];
        z = [z; q_i(4)];

        t_i = t_i + DeltaT;
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

    n_deltaT = 2*length(t);
    DeltaT = t_i/n_deltaT;

    if(erreurEstValide)
        vf = [0; q_i(1); q_i(2)];
        break;
    end
end

endfunction
