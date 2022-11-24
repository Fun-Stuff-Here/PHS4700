function [outArray item] = Pop(array)

    if isempty(array)
        outArray = [];
        item = {};
        return;
    endif

    if length(array) == 1
        outArray = [];
        item = array{1};
        return;
    endif

    item = array{end};
    outArray = {};
    for i = 1:length(array)-1
        outArray{i} = array{i};
    end
endfunction
