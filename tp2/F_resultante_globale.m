function f = F_resultante_globale(context)
% F_resultante_globale: calcule la force resultante globale
% context: contexte de la simulation
% f: force resultante globale

% ------------------------------ Force computation ---------------------- %
    f = F_propulsion_globale(context) + F_frottement_globale(context) + F_gravite_globale(context);
% ------------------------------ Force computation ---------------------- %
endfunction
