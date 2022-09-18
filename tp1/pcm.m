function pcmOut = pcm(context)
    cdm_local = cdm_local(context);
    pcmOut = local_a_global(cdm_local, context);
endfunction

function cdm_local = cdm_local(context)
    drone = {};
    drone.pos = context.pos;
    drone.masse = context.m_s;
    drone.rayon = context.R_s;
    drone.volume = (1/2) * (4/3) * pi * drone.rayon ^ 3;
    drone.masse_volumique = drone.masse / drone.volume;
    z_cdm = pi * drone.masse_volumique * drone.rayon ^ 4 / (4 * drone.masse);
    drone.CDM = [0; 0; z_cdm];

    bras = {};
    bras.CDM = [0; 0; 0];
    bras.masse = 6 * context.m_b;

    moteurs = {};
    moteur.masse = 6 * context.m_m;
    z_cdm = (1/2) * context.H_m;
    moteur.CDM = [0; 0; z_cdm];

    colis = {};
    colis.masse = context.m_c;
    colis.CDM = context.r_c;


    cdm_local = (1/(drone.masse + bras.masse + moteur.masse + colis.masse)) *(drone.masse * drone.CDM + bras.masse * bras.CDM + moteur.masse * moteur.CDM + colis.masse * colis.CDM);
endfunction

function cdm_global = local_a_global(cdm_local, context)
    theta = context.ar;
    R = [cos(theta) 0 sin(theta);
        0 1 0;
        -sin(theta) 0 cos(theta)];
    ajustement_rotation = R * cdm_local;
    cdm_global = context.pos + ajustement_rotation;
endfunction