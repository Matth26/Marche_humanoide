function DrawFoot(T)
%
%  function DrawFoot(T)
%
%
% Inputs;
%  T: 4x4 homogeneous matrix
%

lx=0.05;
ly=0.03;
p(:,1)=[lx;ly;0];
p(:,2)=[-lx;ly;0];
p(:,3)=[-lx;-ly;0];
p(:,4)=[lx;-ly;0];

for i=1:4,
    pt(:,i)=T(1:3,1:3)*p(:,i) + T(1:3,4);
end

for i=1:3,
    xx(1)=pt(1,i);yy(1)=pt(2,i);zz(1)=pt(3,i);
    xx(2)=pt(1,i+1);yy(2)=pt(2,i+1);zz(2)=pt(3,i+1);
    plot3(xx, yy, zz, 'r', 'LineWidth', 2.0);
end

xx(1)=pt(1,4);yy(1)=pt(2,4);zz(1)=pt(3,4);
xx(2)=pt(1,1);yy(2)=pt(2,1);zz(2)=pt(3,1);
plot3(xx, yy, zz, 'r', 'LineWidth', 2.0);