function c=QRotation(quat_de_rotation, vecteur)
%
% Rotation du quaternion vecteur par quat_de_rotation
% 
v1=QProduit(quat_de_rotation, vecteur);
v2=QConjugue(quat_de_rotation);
c=QProduit(v1,v2); 
