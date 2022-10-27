function f = F_resultante_globale(context)
% F_resultante_globale: calcule la force resultante globale
% context: contexte de la simulation
% f: force resultante globale

% -------------------------- function linking --------------------------- %
    F_propulsion = F_propulsion_globale(context);
    F_frottement = F_frottement_globale(context);
    F_gravite = F_gravite_globale(context);
% -------------------------- function linking --------------------------- %

% ------------------------------ Force computation ---------------------- %
    f = F_propulsion + F_frottement + F_gravite;
% ------------------------------ Force computation ---------------------- %
endfunction
