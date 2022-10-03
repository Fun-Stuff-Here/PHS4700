function aaOut = aa(context)

    %Calcul des paramètres de du calcul de l'acceleration angulaire
    R_i = PositionMoteurMatrix(context);
    F_i = ForceMatrixForMotor(context);
    t_cm = MomentForceAuCentreDeMasse(R_i, F_i);
    L = context.MI * context.va;
    va = context.va;

    % ajustement rotation
    theta = context.ar;
    R = [cos(theta) 0 sin(theta);
        0 1 0;
        -sin(theta) 0 cos(theta)];
    ajustement_rotationt_t_cm = R * t_cm;
    ajustement_rotationt_L = R * L;
    ajustement_rotationt_va = R * va;

    %Calcul de l'acceleration angulaire
    aaOut = inv(context.MI) * (ajustement_rotationt_t_cm + cross(ajustement_rotationt_L, ajustement_rotationt_va));
endfunction
