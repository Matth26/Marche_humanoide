clear all
close all
clf
clc 

% Constantes :
z_c = 2; % hauteur du CdM
g = 9.81;
Tc = sqrt(z_c/g);
Tsup = 0.3; % temps d'un appui simple (sur un pied)
Sx = 0.3; % distance en deux pas consécutifs en x
Sy = 0.2; % distance en les deux pieds

x_0 = 0.05; % x à t=0
y_0 = 0.05; % y à t=0

x_p_0 = x_0*((1-cosh(Tsup/Tc))/(Tc*sinh(Tsup/Tc)))+(Sx/(Tc*sinh(Tsup/Tc))); % contrainte sur la vitesse pour que x(0) = x(Tsup)
y_p_0 = y_0*((1-cosh(Tsup/Tc))/(Tc*sinh(Tsup/Tc))); % contrainte sur la vitesse pour que y(0) = y(Tsup)

% Paramètres de marches : 


%s_x = [0 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3];
%s_y = [0.2 -0.2 0.2 -0.2 0.2 -0.2 0.2 -0.2 0.2 -0.2 0.2 -0.2 0.2];
s_x = [0 0.3 0.3 0.3 ];
s_y = [-0.2 0.2 -0.2 0.2];
n = 1:length(s_x);
% S = [   n;
%         s_x;
%         s_y];
    
px = s_x(1);
py = s_y(1);

px_precedent = 0;
py_precedent = 0;
t = zeros(1, length(n)+1);
x = zeros(1, length(n)+1);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
y = zeros(1, length(n)+1);
dx = zeros(1, length(n)+1);
dy = zeros(1, length(n)+1);

% for i=1:1:length(n)
%     if mod(i,2)== 0
%         %px = px_precedent + s_x(i);
%         %py = py_precedent + s_y(i);
%         px = s_x(i);
%         py = s_y(i);
%     else
%         %px = px_precedent + s_x(i);
%         %py = py_precedent + s_y(i);
%         px = s_x(i);
%         py = s_y(i);
%     end
% 
% [x_p_1, y_p_1, x_1, y_1, px_precedent, py_precedent] = primitive_marche2(tf, x_0, y_0, x_p_0, y_p_0, px, py, Tsup);
% x_0 = x_1;
% y_0 = y_1;
% x_p_0 = x_p_1;
% y_p_0 = y_p_1;
% x(i+1) = x_0;
% y(i+1) = y_0;
% dx(i+1) = x_p_0;
% dy(i+1) = y_p_0;
% t(i+1) = t(i) + Tsup;
% end


sx=0.3;% distance entre deux pas sur x
sy=0.2;% distance entre deux pas sur y
offset= 0.1;%offset de continuité entre 2 pas
LIP3D(0, -0.1, sx, -0.1, 0.1, 1)
LIP3D(0, 0.1, sx, 0.1, -0.1, 2)
LIP3D(0, -0.1, sx, -0.1, 0.1, 3)
LIP3D(0, 0.1, sx, 0.1, -0.1, 4)