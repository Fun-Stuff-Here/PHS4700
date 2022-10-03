function I_M1= I_M1(context)
   %moment d'inertie par rapport aux axes
   I_zz = (context.m_m  /2)*(context.R_m)^2
   I_xx_yy = (context.m_m  /4)*(context.R_m)^2 + (context.m_m  /12)*(context.H_m)^2

    Ic = diag([I_xx_yy;I_xx_yy;I_zz])   %tensor

    cdm_cylindre_x = (context.L_b + context.R_s+context.R_m)
    cdm_cylindre_y= 0
    cdm_cylindre_z= context.H_m / 2
    cdm_cylindre = [cdm_cylindre_x;cdm_cylindre_y;cdm_cylindre_z]
    dc = pcm(context) - cdm_cylindre
    Id = id_matrix(dc);%translation des axes
    I_M1= Ic + context.m_m * Id

  endfunction
