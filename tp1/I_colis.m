function I_colis= I_colis(context)

  I_xx = (context.m_c / 12) * ((context.l_c)^2 + (context.H_c)^2);
  I_yy = (context.m_c /12) * ((context.L_c)^2 + (context.H_c)^2);
  I_zz = (context.m_c /12) * ((context.L_c)^2 + (context.l_c)^2);
<<<<<<< HEAD
  Ic = diag([I_xx;I_yy;I_zz]);   %tensor

  cdm_colis= [0;0.1;-0.15];
  dc = cdm_local(context) - cdm_colis;
  Id = id_matrix(dc);%translation des axes

   R = roty(context.ar);  % matrice de rotation y
   I_2_colis= R*Ic*transpose(R);

  I_colis = I_2_colis + context.m_b * Id;
=======

  Ic = diag([I_xx;I_yy;I_zz]);   %tensor

  cdm_colis= [0;0.1;-0.15];
  dc = pcm(context) - cdm_colis;
  Id = id_matrix(dc);%translation des axes
  I_colis = Ic + context.m_b * Id;
>>>>>>> 8a0531fe4cd1ec29875cfe962dcbbff64a07fdd5

endfunction
