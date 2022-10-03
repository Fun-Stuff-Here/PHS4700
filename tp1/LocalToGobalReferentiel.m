function v = LocalToGobalReferentielRotation(context, v)
    u_hat = [   0;
                1;
                0]; % rotation est seulement autour de l'axe y
    u_hat_transposer = sin(context.ar/2)*u_hat.';

    quat_r = [  cos(context.ar/2);
                u_hat_transposer(1);
                u_hat_transposer(2);
                u_hat_transposer(3)]; % quaternion de rotation

    quat_r_conjuger = [ cos(context.ar/2);
                        -u_hat_transposer(1);
                        -u_hat_transposer(2);
                        -u_hat_transposer(3)]; % conjuger de quat_r

    quat_v = [0;
            v(1);
            v(2);
            v(3)]; % vecteur v en quaternion

    %Calul de la rotation rvr*
    quat_v_rotated = ProduitHamiltonien(ProduitHamiltonien(quat_r, quat_v), quat_r_conjuger);

    assert(quat_v_rotated(1) < 1E-5 && quat_v_rotated(1) > -1E-5); % On s'assure que le quaternion est bien un vecteur
    v_rotated = [   quat_v_rotated(2);
                    quat_v_rotated(3);
                    quat_v_rotated(4)]; % vecteur rotationné

    % Calcul de la translation
    v = v_rotated;
endfunction
