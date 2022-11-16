function [delta_q] =  g(problem, q, t)
% g:  the function that defines the differential equation
% q:  the state vector
% t:  the time
% problem:  the problem structure

%  ------------  unpack vecteur d'etat ------------------
    x = q(1);
    y = q(2);
    z = q(3);
    v_x = q(4);
    v_y = q(5);
    v_z = q(6);
    w_x = q(7);
    w_y = q(8);
    w_z = q(9);
    quat_w = q(10);
    quat_x = q(11);
    quat_y = q(12);
    quat_z = q(13);
%  ------------  Fin unpack vecteur d'etat --------------

    quat = [quat_w; quat_x; quat_y; quat_z];
    quat = quat/norm(quat); % normalisation du quaternion pour eviter les erreurs numeriques
    omega_quat = [0; w_x; w_y; w_z];
    delta_quat = 1/2 * QProduit(quat, omega_quat);
    forces = Forces(problem);
    acceleration = Acceleration(problem, forces);
    acceleration_angulaire = AccelerationAngulaire(problem, forces);
    if (problem.hyperparams.debugMode && problem.dice.NCollision > problem.hyperparams.max_nCollision_before_rolling)
        printf(" acceleration = %f %f %f \t acceleration_angulaire = %f %f %f \n", acceleration(1), acceleration(2), acceleration(3), acceleration_angulaire(1), acceleration_angulaire(2), acceleration_angulaire(3));
    endif

    delta_q = [ 
        v_x; % dx/dt
        v_y; % dy/dt
        v_z; % dz/dt
        acceleration(1); % dv_x/dt
        acceleration(2); % dv_y/dt
        acceleration(3); % dv_z/dt
        acceleration_angulaire(1); % dw_x/dt
        acceleration_angulaire(2); % dw_y/dt
        acceleration_angulaire(3); % dw_z/dt
        delta_quat(1); % dquat_w/dt
        delta_quat(2); % dquat_x/dt
        delta_quat(3); % dquat_y/dt
        delta_quat(4); % dquat_z/dt
    ];

endfunction
