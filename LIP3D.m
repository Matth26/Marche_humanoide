function [x_pp, y_pp, x_p, y_p, x, y_plot, px, py, z, tt]=LIP3D(x_0, y_0, px, py, offset, num_pas, z)

% Constantes :
z_c = 0.8; % hauteur du CdM
g = 9.81;
Tc = sqrt(z_c/g);
Tsup = 0.3;

kx = 0.1;
ky = 0.2;

x_p_0 = (px-x_0*cosh(Tsup/Tc))/(Tc*sinh(Tsup/Tc));
y_p_0 = (py-y_0*cosh(Tsup/Tc))/(Tc*sinh(Tsup/Tc));

i = 0;

for t=0:0.01:Tsup
    i = i + 1;
x(i+1) = x_0*cosh(t/Tc)+Tc*x_p_0*sinh(t/Tc);
x_p(i+1) = (x_0/Tc)*sinh(t/Tc)+x_p_0*cosh(t/Tc);
x_pp(i+1) = (x_0/(Tc*Tc))*cosh(t/Tc)+(x_p_0/Tc)*sinh(t/Tc);

y(i+1) = y_0*cosh(t/Tc)+Tc*y_p_0*sinh(t/Tc);
y_p(i+1) = (y_0/Tc)*sinh(t/Tc)+y_p_0*cosh(t/Tc);
y_pp(i+1) = (y_0/(Tc*Tc))*cosh(t/Tc)+(y_p_0/Tc)*sinh(t/Tc);

x_plot(i+1) = x(i+1)+num_pas*px;
y_plot(i+1) = y(i+1)+offset;

%z = kx*x+ky*y+z_c;

tt(i+1)=t;

figure(1)
hold on
plot3(x(i+1)+num_pas*px, y(i+1)+offset, z, 'g.');
xlabel('x (m)');
ylabel('y (m)');
zlabel('z (m)');
grid on;
plot(x(i+1)+num_pas*px, y(i+1)+offset, 'b.');
xlabel('x (m)');
ylabel('y (m)');
plot3([num_pas*px x(i+1)+num_pas*px]', [py y(i+1)+offset]', [0 z]', 'r');
end