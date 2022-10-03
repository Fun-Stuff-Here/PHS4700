function t_cm = MomentForceAuCentreDeMasse(R_i, F_i)
    %Calcul du moment de force au centre de masse
    t_cm = zeros(1,3);
    for i = 1:size(R_i,2)
        t_cm = t_cm + cross(R_i(:,i), F_i(:,i));
    endfor
endfunction
