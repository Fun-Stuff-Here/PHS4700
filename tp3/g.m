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
    quat = quat/norm(quat.'); % normalisation du quaternion pour eviter les erreurs numeriques
    omega_quat = [0; w_x; w_y; w_z];
    delta_quat = 1/2 * QProduit(quat.', omega_quat.');

    delta_q = [ 
        v_x; % dx/dt
        v_y; % dy/dt
        v_z; % dz/dt
        0; % dv_x/dt
        0; % dv_y/dt
        -problem.constants.g; % dv_z/dt
        0; % dw_x/dt
        0; % dw_y/dt
        0; % dw_z/dt
        delta_quat(1); % dquat_w/dt
        delta_quat(2); % dquat_x/dt
        delta_quat(3); % dquat_y/dt
        delta_quat(4); % dquat_z/dt
    ];

endfunction
