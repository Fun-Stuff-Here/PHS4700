function I_B1= I_B1(context)
  %moment d'inertie par rapport aux axes
  I_zz = context.m_b *((context.R_b)^2);
  I_xx_yy = ((context.m_b/2)*(context.R_b)^2) + ((context.m_b/12)*(context.L_b)^2);

  Ic = diag([I_xx_yy;I_xx_yy;I_zz]);   %tensor

  cdm_cylindre_x = (context.L_b/2) + context.R_s;
  cdm_cylindre=[cdm_cylindre_x;0;context.R_b];
  dc = pcm(context) - cdm_cylindre;
  Id = id_matrix(dc);%translation des axes
  I_B1 = Ic + context.m_b * Id;

endfunction
