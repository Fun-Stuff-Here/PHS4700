function sommets = CalculSommetsGlobal(problem)

    % -------- Linking the problem structure to the local variables ------
    sommets_local = problem.dice.sommets;
    quaternion_rotation = problem.dice.q(10:13).';
    position = problem.dice.q(1:3).';
    % -------- Fin Linking the problem structure to the local variables --

    % ----- Calcul des sommets de la boite englobante ---------
    sommet_local_1 = sommets_local(:, 1);
    sommet_local_quat_1 = [0; sommet_local_1(1); sommet_local_1(2); sommet_local_1(3)];
    sommet_1 = position + QProduit(quaternion_rotation, sommet_local_quat_1)(2:4);

    sommet_local_2 = sommets_local(:, 2);
    sommet_local_quat_2 = [0; sommet_local_2(1); sommet_local_2(2); sommet_local_2(3)];
    sommet_2 = position + QProduit(quaternion_rotation, sommet_local_quat_2)(2:4);

    sommet_local_3 = sommets_local(:, 3);
    sommet_local_quat_3 = [0; sommet_local_3(1); sommet_local_3(2); sommet_local_3(3)];
    sommet_3 = position + QProduit(quaternion_rotation, sommet_local_quat_3)(2:4);

    sommet_local_4 = sommets_local(:, 4);
    sommet_local_quat_4 = [0; sommet_local_4(1); sommet_local_4(2); sommet_local_4(3)];
    sommet_4 = position + QProduit(quaternion_rotation, sommet_local_quat_4)(2:4);

    sommet_local_5 = sommets_local(:, 5);
    sommet_local_quat_5 = [0; sommet_local_5(1); sommet_local_5(2); sommet_local_5(3)];
    sommet_5 = position + QProduit(quaternion_rotation, sommet_local_quat_5)(2:4);

    sommet_local_6 = sommets_local(:, 6);
    sommet_local_quat_6 = [0; sommet_local_6(1); sommet_local_6(2); sommet_local_6(3)];
    sommet_6 = position + QProduit(quaternion_rotation, sommet_local_quat_6)(2:4);

    sommet_local_7 = sommets_local(:, 7);
    sommet_local_quat_7 = [0; sommet_local_7(1); sommet_local_7(2); sommet_local_7(3)];
    sommet_7 = position + QProduit(quaternion_rotation, sommet_local_quat_7)(2:4);

    sommet_local_8 = sommets_local(:, 8);
    sommet_local_quat_8 = [0; sommet_local_8(1); sommet_local_8(2); sommet_local_8(3)];
    sommet_8 = position + QProduit(quaternion_rotation, sommet_local_quat_8)(2:4);

    % ----- Fin Calcul des sommets de la boite englobante -----

    sommets =[
        sommet_1(1) sommet_2(1) sommet_3(1) sommet_4(1) sommet_5(1) sommet_6(1) sommet_7(1) sommet_8(1);
        sommet_1(2) sommet_2(2) sommet_3(2) sommet_4(2) sommet_5(2) sommet_6(2) sommet_7(2) sommet_8(2);
        sommet_1(3) sommet_2(3) sommet_3(3) sommet_4(3) sommet_5(3) sommet_6(3) sommet_7(3) sommet_8(3)
    ];

endfunction
