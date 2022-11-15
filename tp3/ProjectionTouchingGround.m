function groundProjection = ProjectionTouchingGround(problem)
% Returns a structure with the following fields:
%   - unitVectors: unit vectors of the projection
%   - origin: origin of the projection
%   - nDims: number of dimensions of the projection

% ------------------------------ Problem Definition ---------------------------------
    close_enough = problem.hyperparams.close_enough;
    sommets = CalculSommetsGlobal(problem);
    l = problem.dice.l;
% ------------------------------ Fin Problem Definition -----------------------------
    groundProjection = {};
    groundProjection.unitVectors = [];
    groundProjection.origin = [0; 0; 0;];
    groundProjection.nDims = 0;

    indexes = sommets(3,:) < close_enough;
    vertex = sommets(:,indexes);
    if (size(vertex,2) < 2) % 0D projection
        groundProjection.nDims = 0;
        groundProjection.origin = vertex;
    else if (size(vertex,2) == 2) % 1D projection
        u_hat = (vertex(:,2) - vertex(:,1))/norm(vertex(:,2) - vertex(:,1));
        groundProjection.nDims = 1;
        groundProjection.origin = vertex(:,1);
        groundProjection.unitVectors = [u_hat];
    else % 2D projection
        vertex = vertex(:,1:3);
        r_1_2 = (vertex(:,2) - vertex(:,1));
        r_1_3 = (vertex(:,3) - vertex(:,1));
        r_2_3 = (vertex(:,3) - vertex(:,2));

        if (abs(l - norm(r_1_2)) > close_enough) % vertex 3 is the hypotenuse
            u_hat = (vertex(:,1) - vertex(:,3))/norm(vertex(:,1) - vertex(:,3));
            t_hat = (vertex(:,2) - vertex(:,3))/norm(vertex(:,2) - vertex(:,3));
            groundProjection.origin = vertex(:,3);
        else if (abs(l-norm(r_1_3)) > close_enough) % vertex 2 is the hypotenuse
            u_hat = (vertex(:,1) - vertex(:,2))/norm(vertex(:,1) - vertex(:,2));
            t_hat = (vertex(:,3) - vertex(:,2))/norm(vertex(:,3) - vertex(:,2));
            groundProjection.origin = vertex(:,2);
        else % vertex 1 is the hypotenuse
            u_hat = (vertex(:,2) - vertex(:,1))/norm(vertex(:,2) - vertex(:,1));
            t_hat = (vertex(:,3) - vertex(:,1))/norm(vertex(:,3) - vertex(:,1));
            groundProjection.origin = vertex(:,1);
        endif
        groundProjection.nDims = 2;
        groundProjection.unitVectors = [u_hat, t_hat];
    endif
endfunction
