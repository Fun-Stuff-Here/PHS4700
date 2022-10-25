function [vf t x y z] = Devoir2(theta)

    epsilon = [ inf; % erreur sur v_y
                inf; % erreur sur v_z
                10;  % erreur sur y
                10;  % erreur sur z
                inf; % erreur sur w_x
                inf; % erreur sur R_1
                inf; % erreur sur R_2
                inf; % erreur sur R_3
                inf; % erreur sur R_4
                inf; % erreur sur m
    ];

    q_0 = [ 0; % v_y
            0; % v_z
            0; % y
            6371025; % z
            0; % w_x
            1; % R_1
            0; % R_2
            0; % R_3
            0; % R_4
            620000; % m
];

    [vf t x y z] = SimulationParContrainte(q_0, epsilon);

    n_points = length(t);
    if (n_points > 1000)
        step_factor = 2;
        while(true)
            sample_size = n_points / step_factor;
            if(sample_size > 100 && sample_size <= 1000-2)
                break;
            end
            step_factor = step_factor / 2;
        end
        for i=1:(n_points-1):step_factor
            new_vf = [new_vf; vf(i)];
            new_t = [new_t; t(i)];
            new_x = [new_x; x(i)];
            new_y = [new_y; y(i)];
            new_z = [new_z; z(i)];
        end
    new_vf = [new_vf; vf(end)];
    new_t = [new_t; t(end)];
    new_x = [new_x; x(end)];
    new_y = [new_y; y(end)];
    new_z = [new_z; z(end)];
    vf = new_vf;
    t = new_t;
    x = new_x;
    y = new_y;
    z = new_z;
    end

endfunction
