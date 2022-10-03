function pcmOut = pcm(context)
    cdm_local = cdm_local(context);
    pcmOut = local_a_global(cdm_local, context);

    % Assertion to test
    cas1 = context.ar == 0 && context.pos == [0;0;0];
    cas2 = context.ar == 0.2 && context.pos == [-3.5;2;40];
    if cas1
        assert(pcmOut(1) == 0);
        assert(0.0135585 < pcmOut(2) && pcmOut(2) < 0.0135595);
        assert(0.0286015 < pcmOut(3) && pcmOut(3) < 0.0286025);
    elseif cas2
        assert(-3.49435 < pcmOut(1) && pcmOut(1) < -3.49425);
        assert(2.01355 < pcmOut(2) && pcmOut(2) < 2.01365);
        assert(40.02795 < pcmOut(3) && pcmOut(3) < 40.02805);
    endif
endfunction

function cdm_global = local_a_global(cdm_local, context)
    theta = context.ar;
    R = [cos(theta) 0 sin(theta);
        0 1 0;
        -sin(theta) 0 cos(theta)];
    ajustement_rotation = R * cdm_local;
    cdm_global = context.pos + ajustement_rotation;
endfunction
