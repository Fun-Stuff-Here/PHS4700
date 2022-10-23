function f = F_resultante_globale(context)
    f = F_propulsion_globale(context) + F_frottement_globale(context) + F_gravite_globale(context);
endfunction