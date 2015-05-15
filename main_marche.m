clear all
close all
clf
clc 

% Paramètres de marches : 

Sx=0.3; % distance entre deux pas sur x
Sy=0.1; % distance entre deux pas sur y
offset= 0.1; % offset de continuité entre 2 pas
x_0 = 0;
y_0 = 0.1;

numero_pas = 0;
nombre_pas = 3;

t_tab = 0;
x_tab = 0;
y_tab = 0;
dx_tab = 0;
dy_tab = 0;
ddx_tab = 0;
ddy_tab = 0;

 for i=1:1:nombre_pas
 numero_pas = i;
 y_0 = -y_0;
 Sy = -Sy;
 offset = -Sy;
 
[x_pp, y_pp, x_p, y_p, x, y, px, py, z, t] = LIP3D(x_0, y_0, Sx, Sy, offset, i, 0.8);

t_tab = [t_tab t(2:end)+t_tab(end)];
x_tab = [x_tab x(2:end)+x_tab(end)];
y_tab = [y_tab y(2:end)+y_tab(end)];
dx_tab = [dx_tab x_p(2:end)];
dy_tab = [dy_tab y_p(2:end)];
ddx_tab = [ddx_tab x_pp(2:end)];
ddy_tab = [ddy_tab y_pp(2:end)];
 end

% AFFICHAGE
figure(2)
subplot(1,2,1) % Figure de forme 2x2
hold
plot(t_tab,dx_tab);
xlabel('Temps (s)');
ylabel('dx/dt (m/s)');
title('Vitesse en x en fonction du temps');
grid on;
subplot(1,2,2);
plot(t_tab,dy_tab);
xlabel('Temps (s)');
ylabel('dy/dt (m/s)');
title('Vitesse en y en fonction du temps');
grid on;

figure(3)
subplot(1,2,1) % Figure de forme 2x2
plot(t_tab,ddx_tab);
xlabel('Temps (s)');
ylabel('d²x/dt² (m/s²)');
title('Acceleration en x en fonction du temps');
grid on;
subplot(1,2,2);
plot(t_tab,ddy_tab);
xlabel('Temps (s)');
ylabel('d²y/dt² (m/s²)');
title('Acceleration en y en fonction du temps');
grid on;
hold off

figure(4)
subplot(1,2,1) % Figure de forme 1x2
hold
plot(t_tab,x_tab);
xlabel('Temps (s)');
ylabel('x (m)');
title('x en fonction du temps');
grid on;
subplot(1,2,2);
plot(t_tab,y_tab);
xlabel('Temps (s)');
ylabel('y (m)');
title('y en fonction du temps');
grid on;
