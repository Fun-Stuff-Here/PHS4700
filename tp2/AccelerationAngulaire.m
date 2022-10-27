function alpha = AccelerationAngulaire(context)
% AccelerationAngulaire
% context : contexte de la simulation

% --------------------------- context linking --------------------------- %
    q_rotation = context.fusee.R;
% --------------------------- context linking --------------------------- %

% -------------------------- function linking --------------------------- %
    I = Inertie(context);
    t = Moment_force_locale(context);
% -------------------------- function linking --------------------------- %

% ---------------------------  computation ------------------------------ %
    alpha_local = inv(I) * t;
    alpha_local_quat = [0; alpha_local(1); alpha_local(2); alpha_local(3)];
    alpha = (QRotation(q_rotation.', alpha_local_quat.')(2:4)).';
% ---------------------------  computation ------------------------------ %
endfunction
