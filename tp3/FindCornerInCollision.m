function sommet = FindCornerInCollision(problem)
% FindCornerInCollision - Find a corner in collision
% problem - the problem structure

    sommets = CalculSommetsGlobal(problem.dice.sommets);
    for i = 1:size(sommets,1)
        if (sommets(i,1) < problem.sol.z)
            sommet = sommets(i,:);
            return;
        end
    end
endfunction
