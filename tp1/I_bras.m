function I_bras= I_bras(context)

  % B1
  %moment d'inertie par rapport aux axes
  I_zz = context.m_b *((context.R_b)^2);
  I_xx_yy = ((context.m_b/2)*(context.R_b)^2) + ((context.m_b/12)*(context.L_b)^2);

  Ic = diag([I_xx_yy;I_xx_yy;I_zz]) ;  %tensor

  cdm_cylindre_x = (context.L_b/2) + context.R_s;
  cdm_cylindre=[cdm_cylindre_x;0;context.R_b];
  dc = cdm_local(context) - cdm_cylindre;
  Id = id_matrix(dc);%translation des axes

  R = roty(context.ar);  % matrice de rotation y
  I_2_B1 = R*Ic*transpose(R);

  I_B1 = I_2_B1+ context.m_b * Id;

  % B2
   %moment d'inertie par rapport aux axes
  I_zz = context.m_b *((context.R_b)^2);
  I_xx_yy = ((context.m_b/2)*(context.R_b)^2) + ((context.m_b/12)*(context.L_b)^2);

  Ic = diag([I_xx_yy;I_xx_yy;I_zz]);   %tensor
  cdm_cylindre_x= ((context.L_b/2) + context.R_s)*cos(pi/3);
  cdm_cylindre_y= ((context.L_b/2) + context.R_s)*sin(pi/3);
  cdm_cylindre_z= context.R_b;
  cdm_cylindre = [cdm_cylindre_x;cdm_cylindre_y;cdm_cylindre_z];
  dc = cdm_local(context) - cdm_cylindre;
  Id = id_matrix(dc);%translation des axes

  R = roty(context.ar);  % matrice de rotation y
  I_2_B2 = R*Ic*transpose(R);

  I_B2 = I_2_B2 + context.m_b * Id;

  % B3
  %moment d'inertie par rapport aux axes
  I_zz = context.m_b *((context.R_b)^2);
  I_xx_yy = ((context.m_b/2)*(context.R_b)^2) + ((context.m_b/12)*(context.L_b)^2);

  Ic = diag([I_xx_yy;I_xx_yy;I_zz]);   %tensor
  cdm_cylindre_x= -((context.L_b/2) + context.R_s)*cos(pi/3);
  cdm_cylindre_y= ((context.L_b/2) + context.R_s)*sin(pi/3);
  cdm_cylindre_z= context.R_b;
  cdm_cylindre = [cdm_cylindre_x;cdm_cylindre_y;cdm_cylindre_z];
  dc =cdm_local(context) - cdm_cylindre;
  Id = id_matrix(dc);%translation des axes

  R = roty(context.ar) ; % matrice de rotation y
  I_2_B3 = R*Ic*transpose(R);

  I_B3 = I_2_B3 + context.m_b * Id;


  % B4
  %moment d'inertie par rapport aux axes
  I_zz = context.m_b *((context.R_b)^2);
  I_xx_yy = ((context.m_b/2)*(context.R_b)^2) + ((context.m_b/12)*(context.L_b)^2);

  Ic = diag([I_xx_yy;I_xx_yy;I_zz]) ;  %tensor

  cdm_cylindre_x = -((context.L_b/2) + context.R_s);
  cdm_cylindre=[cdm_cylindre_x;0;context.R_b];
  dc = cdm_local(context) - cdm_cylindre;
  Id = id_matrix(dc);%translation des axes

  R = roty(context.ar) ; % matrice de rotation y
  I_2_B4 = R*Ic*transpose(R);

  I_B4 = I_2_B4 + context.m_b * Id;


  % B5
  %moment d'inertie par rapport aux axes
  I_zz = context.m_b *((context.R_b)^2);
  I_xx_yy = ((context.m_b/2)*(context.R_b)^2) + ((context.m_b/12)*(context.L_b)^2);

  Ic = diag([I_xx_yy;I_xx_yy;I_zz]);   %tensor
  cdm_cylindre_x= -((context.L_b/2) + context.R_s)*cos(pi/3);
  cdm_cylindre_y= -((context.L_b/2) + context.R_s)*sin(pi/3);
  cdm_cylindre_z= context.R_b;
  cdm_cylindre = [cdm_cylindre_x;cdm_cylindre_y;cdm_cylindre_z];
  dc =cdm_local(context) - cdm_cylindre;
  Id = id_matrix(dc);%translation des axes

  R = roty(context.ar) ; % matrice de rotation y
  I_2_B5 = R*Ic*transpose(R);

  I_B5= I_2_B5+ context.m_b * Id;

  % B6
  %moment d'inertie par rapport aux axes
  I_zz = context.m_b *((context.R_b)^2);
  I_xx_yy = ((context.m_b/2)*(context.R_b)^2) + ((context.m_b/12)*(context.L_b)^2);

  Ic = diag([I_xx_yy;I_xx_yy;I_zz]);   %tensor
  cdm_cylindre_x= ((context.L_b/2) + context.R_s)*cos(pi/3);
  cdm_cylindre_y= -((context.L_b/2) + context.R_s)*sin(pi/3);
  cdm_cylindre_z= context.R_b;
  cdm_cylindre = [cdm_cylindre_x;cdm_cylindre_y;cdm_cylindre_z];
  dc = cdm_local(context) - cdm_cylindre;
  Id = id_matrix(dc);%translation des axes

  R = roty(context.ar) ; % matrice de rotation y
  I_2_B6 = R*Ic*transpose(R);

  I_B6= I_2_B6+ context.m_b * Id;

  I_bras= I_B1+ I_B2+I_B3+I_B4+I_B5+I_B6;
endfunction
