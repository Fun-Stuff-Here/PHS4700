function aaOut = aa(context)

    % Calcul en referenciel du drone
    % Force en jeu, poid, moteur
    ForceMoteur_CM = [0; 0; sum(Lambda * context.F_max)]

%    TorqueMoteur_CM = 


    aaOut = zeros(3,1);
endfunction
