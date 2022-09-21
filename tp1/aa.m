function aaOut = aa(context)

    R_i = PositionMoteurMatrix(context);
    F_i = ForceMatrixForMotor(context);
    t_cm = MomentForceAuCentreDeMasse(R_i, F_i);
    L = context.MI * context.va;

    aa_local = inv(context.MI) * (t_cm + cross(L, context.va));
    aaOut = LocalToGobalReferentiel(context, aa_local);
endfunction
