function f = F_propulsion_globale(context)
    % vitesse [Vx;Vy;Vz] m/s. Utilisé pour avoir la 
    f_locale = F_propulsion_locale(context);
    q_f_locale = [0 f_locale];
    q_rotation = context.q_rotation;
    f = QRotation(q_rotation, q_f_locale)(2:4);
endfunction