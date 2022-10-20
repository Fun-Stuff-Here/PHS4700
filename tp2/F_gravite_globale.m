function f = F_gravite_globale(context)
    masse_terre = 3000000000000; % kg
    masse_fusee = 2; % kg
    G = 6.673 * 10 ^(-11);  % Nm²/Kg²
    r_fusee = [2 3 4];
    option_euclidienne = 2;
    f = (-G * masse_fusee * masse_terre / ( norm(r_fusee, option_euclidienne) ^3 )) * r_fusee;
endfunction

x= F_gravite_globale({});
fprintf(x);
