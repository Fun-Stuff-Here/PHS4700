function f = F_gravite_globale(context)
    masse_terre = context.masse_terre;
    masse_fusee = context.masse_fusee;
    G = 6.673 * 10 ^(-11);  % Nm²/Kg²
    r_fusee = context.r_fusee;
    option_euclidienne = 2;
    f = (-G * masse_fusee * masse_terre / ( norm(r_fusee, option_euclidienne) ^3 )) * r_fusee;
endfunction
