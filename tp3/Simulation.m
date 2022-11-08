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

    while (!StopCondition(problem))
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