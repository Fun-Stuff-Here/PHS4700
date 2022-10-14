function [isConditionMet] = StopCondition(q)
% vectreur d'etat q
    distance = 0^2 + q(3)^2 + q(4)^2;
    if ( (distance >= 10^14) || (distance <= 6371000^2) ) % rayon terre ou 10 000 km
        isConditionMet = true;
    else
        isConditionMet = false;
    end

endfunction
