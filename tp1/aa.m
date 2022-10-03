function aaOut = aa(context)

    R_i = PositionMoteurMatrix(context);
    F_i = ForceMatrixForMotor(context);
    t_cm = LocalToGobalReferentielRotation(context, MomentForceAuCentreDeMasse(R_i, F_i));
    L = LocalToGobalReferentielRotation(context, context.MI * context.va);
    va = LocalToGobalReferentielRotation(context, context.va);

    aaOut = inv(context.MI) * (t_cm + cross(L, va));
endfunction
