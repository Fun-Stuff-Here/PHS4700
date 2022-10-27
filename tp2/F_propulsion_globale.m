function f = F_propulsion_globale(context)
% F_propulsion_globale - Calcul de la force de propulsion globale
%   context : structure contenant les variables de contexte
%   f : vecteur de la force de propulsion globale

% --------------------------- context linking --------------------------- %
    q_rotation = context.R;
% --------------------------- context linking --------------------------- %

% -------------------------- function linking --------------------------- %
    f_locale = F_propulsion_locale(context);
% -------------------------- function linking --------------------------- %

% ---------------------------  computation ------------------------------ %
    q_f_locale = [0 f_locale(1) f_locale(2) f_locale(3)];
    f = QRotation(q_rotation, q_f_locale)(2:4);
% ---------------------------  computation ------------------------------ %
endfunction
