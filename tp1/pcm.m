function pcmOut = pcm(context)
    drone = {};
    drone.pos = context.pos;
    drone.masse = context.m_s;
    drone.rayon = context.R_s;
    drone.volume = (1/2) * (4/3) * pi * drone.rayon ^ 3;
    drone.masse_volumique = drone.masse / drone.volume;
    z_cdm = pi * drone.masse_volumique * drone.rayon ^ 4 / (4 * drone.masse);
    drone.CDM = [0; 0; z_cdm];

    pcmOut = drone.CDM; % Ajuster avec le CDM des bras/moteurs et du Colis
endfunction
