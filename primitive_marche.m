%function []=primitive_marche(tf)

clear all
close all
clf
clc 

x_0 = 0.5;
%x_p_0 = 0;


% Constantes :
z_c = 0.8; % hauteur du CdM
g = 9.81;
Tc = sqrt(z_c/g);
Tsup = 1;
sx = 2;

x_p_0 = x_0*((1-cosh(Tsup/Tc))/(Tc*sinh(Tsup/Tc)))+sx; % contrainte sur la vitesse pour que x(0) = x(Tsup)



for t=0:0.1:Tsup
x = x_0*cosh(t/Tc)+Tc*x_p_0*sinh(t/Tc);
x_p = (x_0/Tc)*sinh(t/Tc)+x_p_0*cosh(t/Tc);

hold on
figure(1)
plot(t, x, 'r+');
figure(2)
plot(t, x_p, 'r+');
end

