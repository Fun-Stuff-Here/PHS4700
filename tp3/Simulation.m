function [t x y z sommets] = Simulation(problem)
% Simulation of the problem
% INPUTS:
% problem: structure containing the problem parameters
% OUTPUTS:
% t: time vector
% x: x position vector
% y: y position vector
% z: z position vector
% sommets: matrix containing the position of the vertices of the dice at each time step

facteur_erreur_collision = problem.hyperparams.facteur_erreur_collision; % factor by which the erreur is divided when a collision occurs
facteur_delta_t = problem.hyperparams.facteur_delta_t; % factor by which the time step is divided when a collision occurs

epsilon = [
    sqrt((1e-2)^2/3); % x
    sqrt((1e-2)^2/3); % y
    sqrt((1e-2)^2/3); % z
    inf; % vx
    inf; % vy
    inf; % vz
    inf; % wx
    inf; % wy
    inf; % wz
    inf; % quat w
    inf; % quat x
    inf; % quat y
    inf; % quat z
];

% Premiere essai de simulation avec une prediction de 100 timestep
debugMode = problem.hyperparams.debugMode;
n_deltaT = problem.hyperparams.n_delta_t_initial; % number of time steps
DeltaT = problem.hyperparams.delta_t_initial; % time step
max_travel_distance_near_collision = problem.hyperparams.max_travel_distance_near_collision; % maximum distance traveled by timestep when it is near a collision
l = problem.dice.l;
R_min = problem.dice.R_min;
last_time = 0;

while(true)
    % -------------------------------Simulation ---------------------------------------------
    % Initialisation
    t_i = 0;
    t = [t_i];
    x = [problem.dice.q(1)];
    y = [problem.dice.q(2)];
    z = [problem.dice.q(3)];
    sommets = {CalculSommetsGlobal(problem)};

    erreurMaximalParDeltaT = epsilon/n_deltaT;
if (debugMode)
%------------------------------------------------------------------------------------------------------------------------------
    figure();
    sommets_plot = sommets{1};
    x_plot = [sommets_plot(1,:)];
    y_plot = [sommets_plot(2,:)];
    z_plot = [sommets_plot(3,:)];
    % ------------------  Affichage du cube ---------------------------
    plot3(x_plot([1,2]), y_plot([1,2]), z_plot([1,2]), 'k');
    hold on;
    plot3(x_plot([1,4]), y_plot([1,4]), z_plot([1,4]), 'k');
    hold on;
    plot3(x_plot([3,4]), y_plot([3,4]), z_plot([3,4]), 'k');
    hold on;
    plot3(x_plot([2,3]), y_plot([2,3]), z_plot([2,3]), 'k');
    hold on;
    plot3(x_plot([1,5]), y_plot([1,5]), z_plot([1,5]), 'k');
    hold on;
    plot3(x_plot([2,6]), y_plot([2,6]), z_plot([2,6]), 'k');
    hold on;
    plot3(x_plot([3,7]), y_plot([3,7]), z_plot([3,7]), 'k');
    hold on;
    plot3(x_plot([4,8]), y_plot([4,8]), z_plot([4,8]), 'k');
    hold on;
    plot3(x_plot([5,6]), y_plot([5,6]), z_plot([5,6]), 'k');
    hold on;
    plot3(x_plot([6,7]), y_plot([6,7]), z_plot([6,7]), 'k');
    hold on;
    plot3(x_plot([7,8]), y_plot([7,8]), z_plot([7,8]), 'k');
    hold on;
    plot3(x_plot([5,8]), y_plot([5,8]), z_plot([5,8]), 'k');
    hold on;
    % ------------------  Fin Affichage du cube -----------------------
    % ------------------  Affichage du sol ----------------------------
    scale = 1.5;
    plot3([scale, scale, -scale, -scale, scale], [scale, -scale, -scale, scale, scale], [0, 0, 0, 0, 0], 'k');
    zlim([0, max(z)+0.1]);
    hold on;
    % ------------------  Fin Affichage du sol ------------------------
    axis("equal");
    xlabel('x')
    ylabel('y')
    zlabel('z')
    title(['t = ' num2str(t(1))]);
    hold on;
    pause(0.01);
%------------------------------------------------------------------------------------------------------------------------------
endif

    while (!StopCondition(problem))

%------------------------------------------------------------------------------------------------------------------------------
if (debugMode && abs(last_time - t_i) >= problem.hyperparams.delta_t_between_frames)
    last_time = t_i;
    sommets_plot = sommets{end};
    x_plot = [sommets_plot(1,:)];
    y_plot = [sommets_plot(2,:)];
    z_plot = [sommets_plot(3,:)];

    % ------------------  Affichage du cube ---------------------------
    plot3(x_plot([1,2]), y_plot([1,2]), z_plot([1,2]), 'k');
    hold on;
    plot3(x_plot([1,4]), y_plot([1,4]), z_plot([1,4]), 'k');
    hold on;
    plot3(x_plot([3,4]), y_plot([3,4]), z_plot([3,4]), 'k');
    hold on;
    plot3(x_plot([2,3]), y_plot([2,3]), z_plot([2,3]), 'k');
    hold on;
    plot3(x_plot([1,5]), y_plot([1,5]), z_plot([1,5]), 'k');
    hold on;
    plot3(x_plot([2,6]), y_plot([2,6]), z_plot([2,6]), 'k');
    hold on;
    plot3(x_plot([3,7]), y_plot([3,7]), z_plot([3,7]), 'k');
    hold on;
    plot3(x_plot([4,8]), y_plot([4,8]), z_plot([4,8]), 'k');
    hold on;
    plot3(x_plot([5,6]), y_plot([5,6]), z_plot([5,6]), 'k');
    hold on;
    plot3(x_plot([6,7]), y_plot([6,7]), z_plot([6,7]), 'k');
    hold on;
    plot3(x_plot([7,8]), y_plot([7,8]), z_plot([7,8]), 'k');
    hold on;
    plot3(x_plot([5,8]), y_plot([5,8]), z_plot([5,8]), 'k');
    axis("equal");
    xlabel('x')
    ylabel('y')
    zlabel('z')
    hold on;
    title(['t = ' num2str(t(end))]);
    pause(0.1);
    % ------------------  Fin Affichage du cube -----------------------

endif

%------------------------------------------------------------------------------------------------------------------------------
        old_q_i = problem.dice.q;

        %update delta_t to travel a distance of max_travel_distance_near_collision by timestep
        if (problem.dice.q(3) < 1.2*R_min && problem.dice.NCollision <= problem.hyperparams.max_nCollision_before_rolling)
            DeltaT = max_travel_distance_near_collision/(max(abs(problem.dice.q(4:6))) + R_min * max(abs(problem.dice.q(7:9))));
        else
            DeltaT = problem.hyperparams.delta_t_initial;
        endif

        [problem.dice.q m Err] = SEDRK4t0ER(problem, problem.dice.q, t_i, t_i + DeltaT, erreurMaximalParDeltaT, 'g');
        % Detection collision and backtracking
        if (DetectCollision(problem))
            if (debugMode && problem.dice.NCollision > problem.hyperparams.max_nCollision_before_rolling)
                printf("omega = %f %f %f \t v = %f %f %f \n", problem.dice.q(7), problem.dice.q(8), problem.dice.q(9), problem.dice.q(4), problem.dice.q(5), problem.dice.q(6));
            endif
            problem.dice.q = old_q_i;
            old_t_i = t_i;
            collision_error = erreurMaximalParDeltaT/facteur_erreur_collision;
            collision_deltaT = DeltaT/facteur_delta_t;
            while (!DetectCollision(problem) && problem.dice.NCollision <= problem.hyperparams.max_nCollision_before_rolling) % get has close as possible to the collision
                if (!DetectCollision(problem)) % guard for not having a station in collision
                    old_q_i = problem.dice.q;
                else
                    problem.dice.q = old_q_i;
                endif
                [problem.dice.q m Err] = SEDRK4t0ER(problem, problem.dice.q, t_i, t_i + collision_deltaT, collision_error, 'g');
                t_i = t_i + collision_deltaT;
            end
            if (problem.dice.NCollision > problem.hyperparams.max_nCollision_before_rolling)
                [problem.dice.q m Err] = SEDRK4t0ER(problem, problem.dice.q, t_i, t_i + DeltaT, erreurMaximalParDeltaT, 'g');
            endif
            sommet_i = FindCornerInCollisionIndex(problem);
            % Backtracking
            problem.dice.q = old_q_i;
            % the collision is now happening
            problem.dice.q = CollisionsMethdodeConditionInitial(problem, sommet_i);
            problem.dice.NCollision = problem.dice.NCollision + 1;
            t_i = old_t_i;
        endif

        % update variables
        t_i = t_i + DeltaT;
        t(end + 1) = t_i;
        x(end + 1) = problem.dice.q(1);
        y(end + 1) = problem.dice.q(2);
        z(end + 1) = problem.dice.q(3);
        sommets(end + 1) = CalculSommetsGlobal(problem);
    end

    % -------------------------------Fin Simulation -----------------------------------------
    if (size(t, 2) > problem.hyperparams.n_delta_t_initial)
        break;
    else
        problem.hyperparams.n_delta_t_initial = problem.hyperparams.n_delta_t_initial/2;
    endif
end

    nPoint = size(t,2);
    stepFactor = 1;
    while(nPoint/stepFactor > problem.hyperparams.n_delta_t_max)
        stepFactor = stepFactor * 2;
    end
    t = t(1:stepFactor:end);
    x = x(1:stepFactor:end);
    y = y(1:stepFactor:end);
    z = z(1:stepFactor:end);
    sommets = sommets(1:stepFactor:end);

endfunction
