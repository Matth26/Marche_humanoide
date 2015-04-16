function T=DHTransform(def, alpha, d, theta, r)
%
% T=DHTransform(def, alpha, d, theta, r)
%
% Compute the homogeneous matrix from the DH parameters
% def: 'standard' or 'modified'
% alpha, d, theta, r : DH parameters
%
%
% if def='standard'
% T=Rot(z,theta)*Trans(z,r)*Trans(x,d)*Rot(x,alpha)
%
% if def='modified'
% T=Rot(x,alpha)*Trans(x,d)*Rot(z,theta)*Trans(z, r)
%

Rot_x_alpha=RotAxeAngle('x', alpha);
Trans_x_d=TransAxeDist('x', d);
Rot_z_theta=RotAxeAngle('z', theta);
Trans_z_r=TransAxeDist('z', r);

if def == 'standard',
    T=Rot_z_theta*Trans_z_r*Trans_x_d*Rot_x_alpha;
elseif def =='modified',
    T=Rot_x_alpha*Trans_x_d*Rot_z_theta*Trans_z_r;
else
    disp('Error: parameter def must be standard or modified --> set T to identity');
    T=eye(4,4);
end