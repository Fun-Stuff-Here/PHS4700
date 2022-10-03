function MIOut = MI(context)

    %  Additionde tous les moment d'inertie
    I_total_local= I_sphere(context)
    + I_B1(context) + I_B2(context) +I_B3(context) +I_B4(context) +I_B5(context) + I_B6(context)
    + I_M1(context)+ I_M2(context)+ I_M3(context)+ I_M4(context)+ I_M5(context)+ I_M6(context)
    + I_colis(context)

    theta = context.ar;
    R = [cos(theta) 0 sin(theta);
       0 1 0;
       -sin(theta) 0 cos(theta)];
    ajustement_rotation = R * I_total_local
    MIOut =I_total_local
endfunction
