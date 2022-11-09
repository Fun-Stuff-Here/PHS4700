function indexes = FindCornerInCollisionIndex(problem)
% FindCornerInCollision - Find a corner in collision
% problem - the problem structure

    sommets = CalculSommetsGlobal(problem);
    indexes = sommets(3,:)<problem.sol.z;
endfunction
