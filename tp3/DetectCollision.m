function isInCollision = DetectCollision(problem)
% This function detects if the current state of the problem is in collision
% with the obstacles. It returns true if there is a collision and false
% otherwise.
% problem: The current problem state
% q: The current state

    sommets = CalculSommetsGlobal(problem);

    sommets_z = sommets(3, :);
    isInCollision = any(sommets_z < problem.sol.z);

endfunction
