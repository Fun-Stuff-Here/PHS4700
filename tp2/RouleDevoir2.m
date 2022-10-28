clear;
format long;

R_espace=10000e3;
angle=0:0.002:2*pi;
xespace=R_espace*cos(angle);
yespace=R_espace*sin(angle);
RT=6.371e6;
angle=0:0.002:2*pi;
xTerre=RT*cos(angle);
yTerre=RT*sin(angle);

plot(xespace, yespace, 'g');
hold on;
fill(xTerre, yTerre, 'b');

axis equal;
xlabel('y(m)')
ylabel('z(m)')
% Valeur de thêta à modifier
theta=0.458;
[Vf t x y z]=Devoir2(theta);
sz=size(t,1);% si la trajectoire n'apparait pas dans la figure, remplacer par sz=size(t,1)
plot(y,z,'r');
hold off;
fprintf('Angle thêtan          %10.9f rad \n',theta);
fprintf('Temps final          %10.6f s \n',t(sz));
fprintf('Vitesse finale          %10.6f m/s \n',Vf);
fprintf('Position finale        ( %10.0f   , %10.0f   ,%10.0f )m \n',x(sz),y(sz),z(sz));
