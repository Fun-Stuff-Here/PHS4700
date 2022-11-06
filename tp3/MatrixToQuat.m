function quat = MatrixToQuat(R)
    q0 = sqrt(1 + R(1,1) + R(2,2) + R(3,3))/2;
    q1 = (R(3,2) - R(2,3))/(4*w);
    q2 = (R(1,3) - R(3,1))/(4*w);
    q3 = (R(2,1) - R(1,2))/(4*w);
    composantes = [q0 q1 q2 q3];
    if (q0 == max(composantes))
        w = q0;
        x = (R(3,2) - R(2,3))/(4*q0);
        y = (R(1,3) - R(3,1))/(4*q0);
        z = (R(2,1) - R(1,2))/(4*q0);
    elseif (q1 == max(composantes))
        x = q1;
        w = (R(3,2) - R(2,3))/(4*q1);
        y = (R(1,2) + R(2,1))/(4*q1);
        z = (R(1,3) + R(3,1))/(4*q1);
    elseif (q2 == max(composantes))
        y = q2;
        w = (R(1,3) - R(3,1))/(4*q2);
        x = (R(1,2) + R(2,1))/(4*q2);
        z = (R(2,3) + R(3,2))/(4*q2);
    else
        z = q3;
        w = (R(2,1) - R(1,2))/(4*q3);
        x = (R(1,3) + R(3,1))/(4*q3);
        y = (R(2,3) + R(3,2))/(4*q3);
    endif

    quat = [ w;
             x;
             y;
             z ];

endfunction
