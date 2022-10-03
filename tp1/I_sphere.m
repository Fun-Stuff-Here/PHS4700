function I_sphere= I_sphere(context) %calcul moment d'inertie du droneen referentiel local

  Ic= diag([83/320,83/320,2/5])*context.m_s * (context.R_s)^2;
  cdm_s = [0;0;(3/8)*(context.R_s)]
  R = roty(context.ar)  % matrice de rotation y
  I_2_sphere = R*Ic*transpose(R);
  dc =  cdm_local(context)-cdm_s;
  Id = id_matrix(dc);
<<<<<<< HEAD
  % translation
  I_sphere = I_2_sphere + Id*context.m_s;
=======
  I_sphere = Ic + Id*context.m_s;
>>>>>>> 8a0531fe4cd1ec29875cfe962dcbbff64a07fdd5

  endfunction
