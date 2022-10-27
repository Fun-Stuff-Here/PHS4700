function a = Acceleration(context)
% context is a structure with constants and variables

% --------------------------- context linking --------------------------- %
m = context.fusee.m;
% --------------------------- context linking --------------------------- %

% -------------------------- function linking --------------------------- %
F = F_resultante_globale(context);
% -------------------------- function linking --------------------------- %

% ---------------------------  computation ------------------------------ %
    a = F/m;
% ---------------------------  computation ------------------------------ %
endfunction
