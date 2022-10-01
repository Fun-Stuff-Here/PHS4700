% Fonction pour trouver l'accélération du centre de masse
function acmOut = acm(context)

  % Données dans l'énoncé (tous en unités SI)
  masse_demi_sphere = 1.5;
  nombre_bras = 6;
  masse_bras = 0.2;
  masse_moteur = 0.4;
  masse_colis = 0.8;
  acceleration_gravitationnelle = [0; 0; -9.81];

  % Calculs pour trouver les masses
  masse_totale_bras = masse_bras * nombre_bras;
  masse_totale_moteurs = masse_moteur * nombre_bras;
  masse_totale_drone = masse_demi_sphere
                     + masse_totale_bras
                     + masse_totale_moteurs;
  masse_totale = masse_colis + masse_totale_drone;

  % Calculs pour trouver les forces gravitationnelles
  force_gravitationnelle_drone = masse_totale_drone * acceleration_gravitationnelle;
  force_gravitationnelle_colis = masse_colis * acceleration_gravitationnelle;

  % Calculs pour trouver les forces des moteurs
  force_moteur1 = calculForceMoteur(context.Lambda(1));
  force_moteur2 = calculForceMoteur(context.Lambda(2));
  force_moteur3 = calculForceMoteur(context.Lambda(3));
  force_moteur4 = calculForceMoteur(context.Lambda(4));
  force_moteur5 = calculForceMoteur(context.Lambda(5));
  force_moteur6 = calculForceMoteur(context.Lambda(6));
  force_resultante = force_moteur1
                   + force_moteur2
                   + force_moteur3
                   + force_moteur4
                   + force_moteur5
                   + force_moteur6
                   + force_gravitationnelle_colis
                   + force_gravitationnelle_drone;

  % Calcul pour trouver l'accélération du centre de masse
    acmOut = force_resultante / masse_totale;

endfunction
