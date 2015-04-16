function R=wedge(a)
%
%  function R=wedge(w)
%
% Create the 3x3 antisymetric matrix from the vector a 
%     ! 0 -az ay !
%  R= ! az 0 -ax !
%     ! -ay ax 0 !
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

R=[0 -a(3) a(2);a(3) 0 -a(1);-a(2) a(1) 0];