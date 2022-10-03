function I_colis= I_colis(context)

  I_xx = (context.m_c / 12) * ((context.l_c)^2 + (context.H_c)^2);
  I_yy = (context.m_c /12) * ((context.L_c)^2 + (context.H_c)^2);
  I_zz = (context.m_c /12) * ((context.L_c)^2 + (context.l_c)^2);

  Ic = diag([I_xx;I_yy;I_zz]);   %tensor

  cdm_colis= [0;0.1;-0.15];
  dc = pcm(context) - cdm_colis;
  Id = id_matrix(dc);%translation des axes
  I_colis = Ic + context.m_b * Id;

endfunction
