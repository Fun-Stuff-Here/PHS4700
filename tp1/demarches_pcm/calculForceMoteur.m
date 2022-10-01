% Fonction pour trouver la force d'un moteur
function forceMoteur = calculForceMoteur(lambda_i)

    % Donnée dans l'énoncé (tous en unités SI)
    force_maximale_moteur = 20;
  
    % Vecteur unitaire en z
    vecteur_unitaire_z = [0; 0; 1]
  
    % Calcul pour trouver la force du moteur
    force = lambda_i * force_maximale_moteur * vecteur_unitaire_z;
  
  endfunction
  