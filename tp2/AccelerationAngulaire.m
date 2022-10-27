function alpha = AccelerationAngulaire(context)
% AccelerationAngulaire
% context : contexte de la simulation

% -------------------------- function linking --------------------------- %
    I = Inertie(context);
    t = Moment_force_locale(context);
% -------------------------- function linking --------------------------- %

% ---------------------------  computation ------------------------------ %
    alpha = inv(I) * t;
% ---------------------------  computation ------------------------------ %

endfunction
