function J=CalcJacobian(robot, footname)
%
%  
%   function CalcJacobian(robot, footname)
%
%   
%   Computes the Jacobian matrix from the chest to the given foot.
%   The considered point for the computation is the ZMP
%
%  Inputs:
%   Robot: data structure of the robot
%   footname: name of the foot
%
%

switch strcmp(footname, 'R_FOOT'),
    case 1,
        id(1)=GetBodyFromName(robot, 'R_HIP');
        id(2)=GetBodyFromName(robot, 'R_THIGH');
        id(3)=GetBodyFromName(robot, 'R_SHIN');
        id(4)=GetBodyFromName(robot, 'R_FOOT');
        p=robot.r_zmp;
    case 0,
        id(1)=GetBodyFromName(robot, 'L_HIP');
        id(2)=GetBodyFromName(robot, 'L_THIGH');
        id(3)=GetBodyFromName(robot, 'L_SHIN');
        id(4)=GetBodyFromName(robot, 'L_FOOT');
        p=robot.l_zmp;
    otherwise,
        disp('Error in CalcJacobian: invalid argument footname');
        J=eye(6,4);
end


T=InverseMatrix(robot.body(1).Tabs);
p=T(1:3,1:3)*p+T(1:3,4);

J=[];
for i=1:4,
    aW=robot.body(id(i)).Tabs(1:3,1:3)*robot.body(id(i)).a; 
    aC=T(1:3,1:3)*aW;
    
    OC=T(1:3,1:3)*robot.body(id(i)).Tabs(1:3,4) + T(1:3,4);
    bC=cross(aC, (p - OC));
    J=[J [bC;aC]];
end