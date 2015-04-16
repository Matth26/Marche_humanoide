%function []=primitive_marche(tf)

clear all
close all
clf
clc 

x_0 = 0.05; % x à t=0
y_0 = 0.05; % y à t=0

% Constantes :
z_c = 2; % hauteur du CdM
g = 9.81;
Tc = sqrt(z_c/g);
Tsup = 0.6; % temps d'un appui simple (sur un pied)
Sx = 0.3; % distance en deux pas consécutifs en x
Sy = 0.2; % distance en les deux pieds
x_p_0 = x_0*((1-cosh(Tsup/Tc))/(Tc*sinh(Tsup/Tc)))+Sx; % contrainte sur la vitesse pour que x(0) = x(Tsup)
y_p_0 = y_0*((1-cosh(Tsup/Tc))/(Tc*sinh(Tsup/Tc))); % contrainte sur la vitesse pour que y(0) = y(Tsup)

kx = 0.1;
ky = 0.1;


for t=0:0.01:Tsup
x = x_0*cosh(t/Tc)+Tc*x_p_0*sinh(t/Tc);
x_p = (x_0/Tc)*sinh(t/Tc)+x_p_0*cosh(t/Tc);
x_pp = (x_0/(Tc*Tc))*cosh(t/Tc)+(x_p_0/Tc)*sinh(t/Tc);

y = y_0*cosh(t/Tc)+Tc*y_p_0*sinh(t/Tc);
y_p = (y_0/Tc)*sinh(t/Tc)+y_p_0*cosh(t/Tc);
y_pp = (y_0/(Tc*Tc))*cosh(t/Tc)+(y_p_0/Tc)*sinh(t/Tc);

z = kx*x+ky*y+z_c;

px = x - (z_c/g)*x_pp;
py = y - (z_c/g)*y_pp;

% hold on
% figure(1)
% plot(t, y, 'r+');
% xlabel('t (s)');
% ylabel('x (m)');
% grid on;
% 
% figure(2)
% plot(t, x_p, 'r+');
% xlabel('t (s)');
% ylabel('dx/dt (m/s)');
% grid on;
% 
% figure(3)
% plot(x, y, 'r+');
% xlabel('x (m)');
% ylabel('y (m)');
% grid on;

figure(4)
hold on
plot3(x, y, z, 'g.');
xlabel('x (m)');
ylabel('y (m)');
zlabel('z (m)');
grid on;
plot(x, y, 'b.');
xlabel('x (m)');
ylabel('y (m)');
plot3([px x]', [py y]', [0 z]', 'r');

end


