function aaOut = aa(context)

    R_i = PositionMoteurMatrix(context);
    F_i = ForceMatrixForMotor(context);
    t_cm = LocalToGobalReferentiel(context, MomentForceAuCentreDeMasse(R_i, F_i));
    L = LocalToGobalReferentiel(context, context.MI * context.va);
    va = LocalToGobalReferentiel(context, context.va);

    aaOut = inv(context.MI) * (t_cm + cross(L, va));
endfunction
