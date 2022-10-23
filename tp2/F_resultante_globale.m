function f = F_resultante_globale(context)
    context_force_force = {};
    % utilisé dans propulsion locale
    context_force.mu = 1200;
    context_force.theta = 0.3;
    context_force.v_gaz_norme = 3.5 * 10 ^ 3 ; % module de la vitesse en m/s

    % Utilise dans propulsion globale
    context_force.q_rotation = q_rotation = [0 1 2 3];

    % utilisé dans F_gravite globale
    context_force.masse_terre = 3000000000000; % kg
    context_force.masse_fusee = 2; % kg
    context_force.r_fusee = (6371*(10^3) + 0.1 * (10^3)) * [0 1 0]; % 100m d'altitude en y. Aussi utilisé dans frottement

    % Frottement
    context_force.hauteur_fusee = 50; % m
    context_force.rayon_fusee = 10; % m
    context_force.C_vis = 0.5;
    context_force.v_fusee = [4 5 6]; % m/s


    f = F_propulsion_globale(context_force) + F_frottement_globale(context_force) + F_gravite_globale(context_force);
endfunction