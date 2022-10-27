function t = Moment_force_locale(context)
% moment force locale de la fusee
% context : contexte de la simulation

% --------------------------- context linking --------------------------- %
    r = context.fusee.POS_PROPULSEUR;
% --------------------------- context linking --------------------------- %

% -------------------------- function linking --------------------------- %
    F = F_propulsion_locale(context);
% -------------------------- function linking --------------------------- %

% ---------------------------  computation ------------------------------ %
    t = cross(r.',F.').';
% ---------------------------  computation ------------------------------ %

endfunction
