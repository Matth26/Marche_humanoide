function T=TransAxeDist(axe, dist)
%
% T=TransAxeDist(axe, dist)
% Compute the 4x4 homogeneous matrix for an
% elementary translation along a given axe
% axe: 'x', 'y', 'z'
% dist: translation distance
%
flag=0;

if axe =='x',
    T=[1 0 0 dist;0 1 0 0;0 0 1 0;0 0 0 1];
    flag=1;
end
if axe =='y',
    T=[1 0 0 0;0 1 0 dist;0 0 1 0;0 0 0 1];
    flag=1;
end
if axe =='z',
    T=[1 0 0 0;0 1 0 0;0 0 1 dist;0 0 0 1];
    flag=1;
end
if flag ~= 1,
    T=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
    disp('Specified axe is not known - set matrix to indentity');
end

            