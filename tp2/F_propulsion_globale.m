function f = F_propulsion_globale(context)
    % vitesse [Vx;Vy;Vz] m/s. Utilisé pour avoir la 
    context = {};
    f_locale = F_propulsion_locale(context);
    q_f_locale = [0 f_locale];
    q_rotation = [0 1 2 3];
    f = QRotation(q_rotation, q_f_locale)
endfunction