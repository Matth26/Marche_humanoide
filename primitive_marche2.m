function [x_p, y_p, x, y, px, py, z]=primitive_marche2(tf, x_0, y_0, x_p_0, y_p_0, px, py, Tsup)

% Constantes :
z_c = 1; % hauteur du CdM
g = 9.81;
Tc = sqrt(z_c/g);


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

% px = x - (z_c/g)*x_pp;
% py = y - (z_c/g)*y_pp;

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


