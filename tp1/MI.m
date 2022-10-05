function MIOut = MI(context)

    %  Additionde tous les moment d'inertie
    MIOut= I_sphere(context) + I_bras(context) + I_moteurs(context)+ I_colis(context);

endfunction
