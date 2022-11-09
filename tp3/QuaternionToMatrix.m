function R = QuaternionToMatrix(q)
% QuaternionToMatrix - Convert a quaternion to a rotation matrix
% q = [w x y z]
% R = [R11 R12 R13
%      R21 R22 R23
%      R31 R32 R33]
% https://automaticaddison.com/how-to-convert-a-quaternion-to-a-rotation-matrix/
    R11 = 2*(q(1)^2 + q(2)^2) - 1;
    R12 = 2*(q(2)*q(3) - q(1)*q(4));
    R13 = 2*(q(2)*q(4) + q(1)*q(3));
    R21 = 2*(q(2)*q(3) + q(1)*q(4));
    R22 = 2*(q(1)^2 + q(3)^2) - 1;
    R23 = 2*(q(3)*q(4) - q(1)*q(2));
    R31 = 2*(q(2)*q(4) - q(1)*q(3));
    R32 = 2*(q(3)*q(4) + q(1)*q(2));
    R33 = 2*(q(1)^2 + q(4)^2) - 1;
    R = [R11 R12 R13;
         R21 R22 R23;
         R31 R32 R33];

endfunction
