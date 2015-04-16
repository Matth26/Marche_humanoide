function R=Rodrigues(a, theta)
%
%
%  function R=Rodrigues(a, theta)
%
% Compute the 3x3 rotation matrix from the velocity rotation vector a
% for the angle theta
%
% R= Id + (a^)*sin(theta) + (a^)*(a^)*(&-cos(theta))
%
% where a^ is the antisymetric matrix computed from the vector a
%

[m,n]=size(a);
if m ~= 3,
    disp('Invalid size for input');
    return;
end
if n ~= 1,
    disp('Invalid size for input');
    return;
end

aa=wedge(a);
R=eye(3,3) + aa*sin(theta) + aa*aa*(1 - cos(theta));