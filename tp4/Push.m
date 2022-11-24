function out = Push(array, item)

    array{end+1} = item;
    out = array;

endfunction
