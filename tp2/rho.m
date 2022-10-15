function p = rho(position_fusee)
    % position_fusee: la position de la fusée [x;y;z]
    rho_o = 1.275; % Kg/m^3
    H_0 = 7200; % mètres
    R_t = 6371 * (10 ^ 3); % En mètres
    norme_position = norm(position_fusee);
    p = rho_o * exp( (R_t - norme_position)/H_0 );
endfunction