function quat = MatrixToQuat(R)
    w = sqrt(1 + R(1,1) + R(2,2) + R(3,3))/2;
    x = (R(3,2) - R(2,3))/(4*w);
    y = (R(1,3) - R(3,1))/(4*w);
    z = (R(2,1) - R(1,2))/(4*w);
    quat = [ w;
             x;
             y;
             z ];

endfunction
