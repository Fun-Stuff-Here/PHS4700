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
n_deltaT = 100;
DeltaT = 1e-2;

while(true)
    % -------------------------------Simulation ---------------------------------------------
    % Initialisation
    q_i = problem.dice.q;
    t_i = 0;
    t = [t_i];
    x = [q_i(1)];
    y = [q_i(2)];
    z = [q_i(3)];
    sommets = {CalculSommetsGlobal(problem)};

    erreurMaximalParDeltaT = epsilon./n_deltaT;

    i = 1;
%------------------------------------------------------------------------------------------------------------------------------
    figure;
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
    pause(0.3);
%------------------------------------------------------------------------------------------------------------------------------

    while (!StopCondition(problem))

%------------------------------------------------------------------------------------------------------------------------------
if (mod(i,7) == 0)
    sommets_plot = sommets{i};
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
    title(['t = ' num2str(t(i))]);
    % ------------------  Fin Affichage du cube -----------------------

    pause(0.1); %// update plot
endif
i = i+1;
%------------------------------------------------------------------------------------------------------------------------------

        old_q_i = q_i;
        [q_i m Err]= SEDRK4t0ER(problem, q_i, t_i, t_i + DeltaT, erreurMaximalParDeltaT, 'g');
        problem.dice.q = q_i;
        % Detection collision and backtracking
        if (DetectCollision(problem))
            q_i = old_q_i;
            problem.dice.q = old_q_i;
            collision_error = erreurMaximalParDeltaT./facteur_erreur_collision;
            collision_deltaT = DeltaT/facteur_delta_t;
            while (!DetectCollision(problem)) % get has close as possible to the collision
                old_q_i = q_i;
                problem.dice.q = q_i;
                [q_i m Err]= SEDRK4t0ER(problem, q_i, t_i, t_i + collision_deltaT, collision_error, 'g');
                t_i = t_i + collision_deltaT;
            end
            sommet_i = FindCornerInCollisionIndex(problem);
            % Backtracking
            problem.dice.q = old_q_i;
            t_i = t_i - collision_deltaT;
            % the collision is now happening
            q_i = CollisionsMethdodeConditionInitial(problem, sommet_i);
            problem.dice.q = q_i;
        endif

        % update variables
        t_i = t_i + DeltaT;
        t(end + 1) = t_i;
        x(end + 1) = q_i(1);
        y(end + 1) = q_i(2);
        z(end + 1) = q_i(3);
        sommets(end + 1) = CalculSommetsGlobal(problem);
    end

    % -------------------------------Fin Simulation -----------------------------------------

    % calcul erreur comis
    erreur_comis = erreurMaximalParDeltaT .* length(t);
    erreurEstValide = true;
    for i = 1:length(erreur_comis)
        if (erreur_comis(i) > epsilon(i))
            erreurEstValide = false;
        end
    end

    % si erreur comis < epsilon alors on arrete la simulation
    if(erreurEstValide)
        break;
    end

    % sinon on augmente le nombre de pas de temps et diminue delta t
    n_deltaT = 2*length(t) + 1;
    DeltaT = t(end)/n_deltaT;
end

endfunction
