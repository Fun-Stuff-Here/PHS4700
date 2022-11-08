function index = FindCornerInCollisionIndex(problem)
% FindCornerInCollision - Find a corner in collision
% problem - the problem structure

    sommets = CalculSommetsGlobal(problem);
    [sommet_min, index] = min(sommets(3,:));
endfunction
