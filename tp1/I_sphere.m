function I_sphere= I_sphere(context) %calcul moment d'inertie du droneen referentiel local

  Ic= diag([83/320,83/320,2/5])*context.m_s * (context.R_s)^2;
  cdm_s = (3/8)*(context.R_s);
  dc =  pcm(context)-cdm_s;
  Id = id_matrix(dc);
  I_sphere = Ic + Id*context.m_s;

  endfunction
