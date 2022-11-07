function face = CalculFaceObtenue(problem)
% Calcul de la face obtenue par le joueur
% problem : structure contenant les données du problème
% face : face obtenue par le joueur 
% return -1 si il n'y a pas de face obtenue

    sommets = CalculSommetsGlobal(problem);
    coins = []
    for i = 1:4
        indexes = []
        for j = 1:8
            if !(any(coins == j))
                indexes = [indexes j];
            end
        end
        [x, ix] = max(sommets(3, indexes));
        coins = [coins ix];
    end
    
    face_1 = [1, 2, 3, 4];
    face_2 = [3, 4, 7, 8];
    face_3 = [2, 3, 6, 7];
    face_4 = [1, 4, 5, 8];
    face_5 = [1, 2, 5, 6];
    face_6 = [5, 6, 7, 8];

    if (all(ismember(coins, face_1)))
        face = 1;
    elseif (all(ismember(coins, face_2)))
        face = 2;
    elseif (all(ismember(coins, face_3)))
        face = 3;
    elseif (all(ismember(coins, face_4)))
        face = 4;
    elseif (all(ismember(coins, face_5)))
        face = 5;
    elseif (all(ismember(coins, face_6)))
        face = 6;
    else
        face = -1;
    end

endfunction
