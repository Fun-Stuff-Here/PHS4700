function Id_matrix= id_matrix(dc_matrix) % matrice pour translation des axes par rapport a un point arbitraire

      matrix= [(dc_matrix(2))^2 + (dc_matrix(3))^2, -(dc_matrix(1))*(dc_matrix(2)),-(dc_matrix(1))*(dc_matrix(3));
      -(dc_matrix(2))*(dc_matrix(1)), (dc_matrix(1))^2 + (dc_matrix(3))^2,-(dc_matrix(2))*(dc_matrix(3));
      -(dc_matrix(3))*(dc_matrix(1)),-(dc_matrix(3))*(dc_matrix(2)),(dc_matrix(1))^2 + (dc_matrix(2))^2];
        Id_matrix=matrix;

      Id_matrix=matrix;
  endfunction
