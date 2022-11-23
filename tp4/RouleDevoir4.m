clear

for i=1:4
    if i==1
        Robs = [20; 20; 10];
        nint = 1.5;
        next = 1;
    endif
    if i==2
        Robs = [0; 20; 2];
        nint = 1.5;
        next = 1;
    endif
    if i==3
        Robs = [0; 0; 10];
        nint = 1.5;
        next = 1;
    endif
    if i==4
        Robs = [0; 0; 10];
        nint = 1;
        next = 1.5;
    endif
    [xi, yi, zi, face] = Devoir4(Robs, nint, next)
    scatter3(xi, yi, zi, 8, face);
    pause(1);
end
