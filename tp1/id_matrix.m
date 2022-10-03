function Id_matrix= id_matrix(dc_matrix) % matrice pour translation des axes par rapport a un point arbitraire

      matrix= [(dc_matrix(2))^2 + (dc_matrix(3))^2, -(dc_matrix(1))*(dc_matrix(2)),-(dc_matrix(1))*(dc_matrix(3));
      -(dc_matrix(2))*(dc_matrix(1)), (dc_matrix(1))^2 + (dc_matrix(3))^2,-(dc_matrix(2))*(dc_matrix(3));
      -(dc_matrix(3))*(dc_matrix(1)),-(dc_matrix(3))*(dc_matrix(2)),(dc_matrix(1))^2 + (dc_matrix(2))^2];
<<<<<<< HEAD
        Id_matrix=matrix;
=======
>>>>>>> 8a0531fe4cd1ec29875cfe962dcbbff64a07fdd5

      Id_matrix=matrix;
  endfunction
