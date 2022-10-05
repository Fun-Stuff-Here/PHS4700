% Fonction pour trouver l'accélération du centre de masse
function acmOut = acm(context)

  % Données dans l'énoncé (tous en unités SI)
  masse_demi_sphere = 1.5;
  nombre_bras = 6;
  masse_bras = 0.2;
  masse_moteur = 0.4;
  masse_colis = 0.8;
  acceleration_gravitationnelle = [0; 0; -9.81];

  % Calculs pour aller des radians à des degrés
  angle_rotation = (context.ar * 180) / pi;
  matrice_rotation = roty(angle_rotation);

  % Calculs pour trouver les masses
  masse_totale_bras = masse_bras * nombre_bras;
  masse_totale_moteurs = masse_moteur * nombre_bras;
  masse_totale_drone = masse_demi_sphere ...
                     + masse_totale_bras ...
                     + masse_totale_moteurs;
  masse_totale = masse_colis + masse_totale_drone;

  % Calculs pour trouver la force gravitationnelle
  force_gravitationnelle_totale = masse_totale * acceleration_gravitationnelle;

  % Calculs pour trouver les forces des moteurs
  force_totale_moteurs = context.Lambda * context.F_max;
  force_moteur1 = [0; 0; force_totale_moteurs(1)];
  force_moteur2 = [0; 0; force_totale_moteurs(2)];
  force_moteur3 = [0; 0; force_totale_moteurs(3)];
  force_moteur4 = [0; 0; force_totale_moteurs(4)];
  force_moteur5 = [0; 0; force_totale_moteurs(5)];
  force_moteur6 = [0; 0; force_totale_moteurs(6)];

  % Calculs pour appliquer la rotation sur les forces des moteurs
  force_moteur1_rotation = matrice_rotation * force_moteur1;
  force_moteur2_rotation = matrice_rotation * force_moteur2;
  force_moteur3_rotation = matrice_rotation * force_moteur3;
  force_moteur4_rotation = matrice_rotation * force_moteur4;
  force_moteur5_rotation = matrice_rotation * force_moteur5;
  force_moteur6_rotation = matrice_rotation * force_moteur6;

  % Calcul pour trouver l'accélération du centre de masse
  force_moteur_X = force_moteur1_rotation(1) ...
            + force_moteur2_rotation(1) ...
            + force_moteur3_rotation(1) ...
            + force_moteur4_rotation(1) ...
            + force_moteur5_rotation(1) ...
            + force_moteur6_rotation(1);

  force_moteur_Y = force_moteur1_rotation(2) ...
            + force_moteur2_rotation(2) ...
            + force_moteur3_rotation(2) ...
            + force_moteur4_rotation(2) ...
            + force_moteur5_rotation(2) ...
            + force_moteur6_rotation(2);

  force_moteur_Z = force_moteur1_rotation(3) ...
            + force_moteur2_rotation(3) ...
            + force_moteur3_rotation(3) ...
            + force_moteur4_rotation(3) ...
            + force_moteur5_rotation(3) ...
            + force_moteur6_rotation(3) ...
            + force_gravitationnelle_totale;

  acmOut = [force_moteur_X; force_moteur_Y; force_moteur_Z] / masse_totale;

endfunction
