function TI=InverseMatrix(T)

%
% Compute the inverse matrix from the homogeneous matrix T
%     [R   P]
%  T= [     ]
%     [0   1]
%
%      [Rt   -Rt*P]
%  TI= [          ]
%      [0        1]
%
R=T(1:3,1:3);
P=T(1:3,4);
TI=[R' -R'*P;zeros(1,3) 1];
