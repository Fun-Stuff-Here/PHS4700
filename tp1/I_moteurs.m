function I_moteurs= I_moteurs(context)

   % M1
   %moment d'inertie par rapport aux axes
   I_zz = (context.m_m  /2)*(context.R_m)^2;
   I_xx_yy = (context.m_m  /4)*(context.R_m)^2 + (context.m_m  /12)*(context.H_m)^2;

    Ic = diag([I_xx_yy;I_xx_yy;I_zz]);   %tensor

    cdm_cylindre_x = (context.L_b + context.R_s+context.R_m);
    cdm_cylindre_y= 0;
    cdm_cylindre_z= context.H_m / 2;
    cdm_cylindre = [cdm_cylindre_x;cdm_cylindre_y;cdm_cylindre_z];
    dc = cdm_local(context) - cdm_cylindre;
    Id = id_matrix(dc);%translation des axes

    R = roty(context.ar);  % matrice de rotation y
    I_2_M1= R*Ic*transpose(R);

    I_M1= I_2_M1 + context.m_m * Id;

    % M2
    %moment d'inertie par rapport aux axes
    I_zz = (context.m_m  /2)*(context.R_m)^2;
    I_xx_yy = (context.m_m  /4)*(context.R_m)^2 + (context.m_m  /12)*(context.H_m)^2;

    Ic = diag([I_xx_yy;I_xx_yy;I_zz])  ; %tensor

    cdm_cylindre_x = (context.L_b + context.R_s+context.R_m) * cos(pi/3);
    cdm_cylindre_y= (context.L_b + context.R_s+context.R_m) * sin(pi/3);
    cdm_cylindre_z= context.H_m / 2;
    cdm_cylindre = [cdm_cylindre_x;cdm_cylindre_y;cdm_cylindre_z];
    dc = cdm_local(context) - cdm_cylindre;
    Id = id_matrix(dc);%translation des axes

    R = roty(context.ar);  % matrice de rotation y
    I_2_M2= R*Ic*transpose(R);

    I_M2= I_2_M2 + context.m_m * Id;

    % M3
    %moment d'inertie par rapport aux axes
    I_zz = (context.m_m  /2)*(context.R_m)^2;
    I_xx_yy = (context.m_m  /4)*(context.R_m)^2 + (context.m_m  /12)*(context.H_m)^2;

    Ic = diag([I_xx_yy;I_xx_yy;I_zz]);   %tensor

    cdm_cylindre_x = -(context.L_b + context.R_s+context.R_m)*cos(pi/3);
    cdm_cylindre_y= (context.L_b + context.R_s+context.R_m)*sin(pi/3);
    cdm_cylindre_z= context.H_m / 2;
    cdm_cylindre = [cdm_cylindre_x;cdm_cylindre_y;cdm_cylindre_z];
    dc = cdm_local(context) - cdm_cylindre;
    Id = id_matrix(dc);%translation des axes

    R = roty(context.ar);  % matrice de rotation y
    I_2_M3= R*Ic*transpose(R);

    I_M3= I_2_M3 + context.m_m * Id;

    % M4
    %moment d'inertie par rapport aux axes
    I_zz = (context.m_m  /2)*(context.R_m)^2;
    I_xx_yy = (context.m_m  /4)*(context.R_m)^2 + (context.m_m  /12)*(context.H_m)^2;

    Ic = diag([I_xx_yy;I_xx_yy;I_zz]);   %tensor

    cdm_cylindre_x = -(context.L_b + context.R_s+context.R_m)*cos(pi/3);
    cdm_cylindre_y= 0;
    cdm_cylindre_z= context.H_m / 2;
    cdm_cylindre = [cdm_cylindre_x;cdm_cylindre_y;cdm_cylindre_z];
    dc = cdm_local(context) - cdm_cylindre;
    Id = id_matrix(dc);%translation des axes

    R = roty(context.ar);  % matrice de rotation y
    I_2_M4= R*Ic*transpose(R);

    I_M4= I_2_M4 + context.m_m * Id;

    % M5
    %moment d'inertie par rapport aux axes
    I_zz = (context.m_m  /2)*(context.R_m)^2;
    I_xx_yy = (context.m_m  /4)*(context.R_m)^2 + (context.m_m  /12)*(context.H_m)^2;

    Ic = diag([I_xx_yy;I_xx_yy;I_zz]) ;  %tensor

    cdm_cylindre_x = -(context.L_b + context.R_s+context.R_m)*cos(pi/3);
    cdm_cylindre_y= -(context.L_b + context.R_s+context.R_m)*sin(pi/3);
    cdm_cylindre_z= context.H_m / 2;
    cdm_cylindre = [cdm_cylindre_x;cdm_cylindre_y;cdm_cylindre_z];
    dc = cdm_local(context) - cdm_cylindre;
    Id = id_matrix(dc);%translation des axes

    R = roty(context.ar);  % matrice de rotation y
    I_2_M5= R*Ic*transpose(R);

    I_M5= I_2_M5 + context.m_m * Id;

    %M6
    %moment d'inertie par rapport aux axes
    I_zz = (context.m_m  /2)*(context.R_m)^2;
    I_xx_yy = (context.m_m  /4)*(context.R_m)^2 + (context.m_m  /12)*(context.H_m)^2;

    Ic = diag([I_xx_yy;I_xx_yy;I_zz])  ; %tensor

    cdm_cylindre_x = (context.L_b + context.R_s+context.R_m)*cos(pi/3);
    cdm_cylindre_y= -(context.L_b + context.R_s+context.R_m)*sin(pi/3);
    cdm_cylindre_z= context.H_m / 2;
    cdm_cylindre = [cdm_cylindre_x;cdm_cylindre_y;cdm_cylindre_z];
    dc = cdm_local(context) - cdm_cylindre;
    Id = id_matrix(dc);%translation des axes

    R = roty(context.ar);  % matrice de rotation y
    I_2_M6= R*Ic*transpose(R);

    I_M6= I_2_M6 + context.m_m * Id;

    I_moteurs = I_M1+ I_M2+I_M3+I_M4+I_M5+I_M6;

  endfunction
