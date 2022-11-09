function qs = CollisionsMethdodeConditionInitial(problem, sommet_i)
    % This function is used to determine the state vector after the collision
    % problem is the problem structure
    % sommet_i is the index of corner that is in collision

    % -------- Linking the problem structure to the local variables ------
    v_i = problem.dice.q(4:6).';
    omega_i = problem.dice.q(7:9).';

    quaternion_rotation = problem.dice.q(10:13).';
    quaternion_rotation = quaternion_rotation./norm(quaternion_rotation);
    cornersInColision = problem.dice.sommets(:, sommet_i);

    if size(cornersInColision, 2) == 1
        P = cornersInColision;
    else
        P = sum(cornersInColision)/size(cornersInColision, 2);
    endif
    quat_corner = [0; P(1); P(2); P(3)];
    r_a_p = QRotation(quaternion_rotation, quat_corner.')(2:4);

    v_a_p = v_i + (cross(omega_i.', r_a_p.')).';
    v_b_p = problem.sol.v.';
    epsilon = problem.dice.epsilon;
    R = QuaternionToMatrix(quaternion_rotation);
    I_inv_a = R * problem.dice.I_inv * R.';
    I_inv_b = problem.sol.I_inv;
    n_hat = problem.sol.n_hat.';
    r_b_p = [0 0 0];
    mu_c = problem.dice.mu_c;
    mu_s = problem.dice.mu_s;
    m_a = problem.dice.m;
    m_b = problem.sol.m;
    % -------- Fin Linking the problem structure to the local variables --


    % -------- Calcul de l'inpulsion j_t --------------------------------
    v_r_vec = v_a_p - v_b_p;
    v_r = dot(n_hat.', v_r_vec.');
    u_hat = (cross(v_r_vec.', n_hat.').')./(norm(cross(v_r_vec.', n_hat.')));
    t_hat = cross(n_hat.', u_hat.').';

    G_a_t = dot(t_hat.', cross(I_inv_a * cross(r_a_p.', t_hat.'), r_a_p.'));
    G_b_t = dot(t_hat.', cross(I_inv_b * cross(r_b_p.', t_hat.'), r_b_p'));
    alpha_t = 1 / (1/m_a + 1/m_b + G_a_t + G_b_t);

    if (mu_s * (1+epsilon)*abs(v_r) < abs(dot(t_hat.', v_r_vec.')))
        j_t = alpha_t * mu_c * (1+epsilon)*v_r;
        G_a = dot(n_hat.', cross(I_inv_a * cross(r_a_p.', n_hat.'), r_a_p.'));
    else
        j_t = -alpha_t * abs(dot(t_hat.', v_r_vec.'));
        G_a = 0;
    end
    % -------- Fin Calcul de l'inpulsion j_t ----------------------------

    % -------- Calcul de l'inpulsion j ----------------------------------
    G_b = dot(n_hat.', cross(I_inv_b * cross(r_b_p.', n_hat.'), r_b_p.'));
    alpha = 1 / (1/m_a + 1/m_b + G_a + G_b);
    j = -alpha*(1+epsilon)*v_r;
    % -------- Fin Calcul de l'inpulsion j ------------------------------

    % -------- Calcul de l'inpulsion J ----------------------------------
    J = j*n_hat + j_t*t_hat;
    % -------- Fin Calcul de l'inpulsion J ------------------------------

    % -------- Calcul de la nouvelle vitesse ----------------------------
    v_f = v_i + J./m_a;
    % -------- Fin Calcul de la nouvelle vitesse ------------------------

    % -------- Calcul de la nouvelle rotation ---------------------------
    omega_f = omega_i + I_inv_a * cross(r_a_p.', J.');
    % -------- Fin Calcul de la nouvelle rotation -----------------------

    % -------- Mettre a jour le vecteur d'etat --------------------------
    problem.dice.q(4) = v_f(1);
    problem.dice.q(5) = v_f(2);
    problem.dice.q(6) = v_f(3);
    problem.dice.q(7) = omega_f(1);
    problem.dice.q(8) = omega_f(2);
    problem.dice.q(9) = omega_f(3);
    % -------- Fin Mettre a jour le vecteur d'etat ----------------------

    qs = problem.dice.q;

endfunction
