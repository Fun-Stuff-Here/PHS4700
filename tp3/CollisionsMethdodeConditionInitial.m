function qs = CollisionsMethdodeConditionInitial(problem, cornerInColision)
    % This function is used to determine the state vector after the collision
    % problem is the problem structure
    % cornerInColision is the corner that is in collision

    % -------- Linking the problem structure to the local variables ------
    v_a_p = problem.dice.q(4:6).';
    v_i = v_a_p;
    v_b_p = problem.sol.v;
    epsilon = problem.dice.epsilon;
    I_inv_a = problem.dice.I_inv;
    I_inv_b = problem.sol.I_inv;
    n_hat = problem.sol.n_hat;
    quaternion_rotation = problem.dice.q(10:13).';
    quat_corner = [0; cornerInColision(1); cornerInColision(2); cornerInColision(3)];
    r_a_p = QRotation(quaternion_rotation, quat_corner);
    r_b_p = [0; 0; 0];
    mu_c = problem.dice.mu_c;
    mu_s = problem.dice.mu_s;
    m_a = problem.dice.m;
    m_b = problem.sol.m;
    omega_i = problem.dice.q(7:9).';
    % -------- Fin Linking the problem structure to the local variables --

    % -------- Calcul de l'inpulsion j ----------------------------------
    v_r_vec = v_a_p - v_b_p;
    v_r = dot(n_hat.', v_r_vec.');
    G_a = dot(n_hat.', cross(I_inv_a * cross(r_a_p.', n_hat.').', r_a_p.'));
    G_b = dot(n_hat.', cross(I_inv_b * cross(r_b_p.', n_hat.').', n_hat.'));
    alpha = 1 / (1/m_a + 1/m_b + G_a + G_b);
    j = -alpha*(1+epsilon)*v_r;
    % -------- Fin Calcul de l'inpulsion j ------------------------------

    % -------- Calcul de l'inpulsion j_t --------------------------------
    u_hat = (cross(v_r_vec.', n_hat.').')./(norm(cross(v_r_vec.', n_hat.')));
    t_hat = cross(n_hat.', u_hat.').';

    G_a_t = dot(t_hat.', cross(I_inv_a * cross(r_a_p.', t_hat.').', r_a_p.'));
    G_b_t = dot(t_hat.', cross(I_inv_b * cross(r_b_p.', t_hat.').', r_b_p'));
    alpha_t = 1 / (1/m_a + 1/m_b + G_a_t + G_b_t);

    if (mu_s * (1+epsilon)*abs(v_r) < abs(dot(t_hat.', v_r_vec.')))
        j_t = alpha_t * mu_c * (1+epsilon)*v_r;
    else
        j_t = -alpha_t * abs(dot(t_hat.', v_r_vec.'));
    end
    % -------- Fin Calcul de l'inpulsion j_t ----------------------------

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
    problem.dice.q(4:6) = v_f.';
    problem.dice.q(7:9) = omega_f.';
    % -------- Fin Mettre a jour le vecteur d'etat ----------------------

    qs = problem.dice.q;

endfunction
