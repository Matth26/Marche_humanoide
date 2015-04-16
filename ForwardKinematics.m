function robot=ForwardKinematics(robot, listofbody)
%
%  function robot=ForwardKinematics(robot, ibody)
%
%  Computes recursively the forward kinematics - compute the pose of each body
%  in the world frame from the current joint values. The result is
%  stored in the 4x4 homogeneous matrix Tabs of each body
%
%  Inputs:
%   robot: data structure of the robot
%   listofbody: list of body names
%
%  Outputs:
%   robot: data structure of the robot

if isempty(listofbody),
    return;
end

[n,m]=size(listofbody);

for i=1:n,
    id_body=GetBodyFromName(robot, listofbody(i,:));
    id_father=GetBodyFromName(robot, robot.body(id_body).father(1,:));
    
    %Get the pose of the father
    R0=robot.body(id_father).Tabs(1:3,1:3);
    p0=robot.body(id_father).Tabs(1:3,4);
    
    % Computes the pose of the current body
    p=R0*robot.body(id_body).b + p0;
    R=R0*Rodrigues(robot.body(id_body).a, robot.body(id_body).q);
    robot.body(id_body).Tabs=[R p;zeros(1,3) 1];
    
    % Computes the ZMP
    if strcmp(robot.body(id_body).name, 'R_FOOT'),
        robot.r_zmp=robot.body(id_body).Tabs(1:3,4) - robot.body(id_body).Tabs(1:3,3)*robot.h_zmp;
    end
    
    if strcmp(robot.body(id_body).name, 'L_FOOT'),
        robot.l_zmp=robot.body(id_body).Tabs(1:3,4) - robot.body(id_body).Tabs(1:3,3)*robot.h_zmp;
    end
    
    % Propagate the computation on the child
    robot=ForwardKinematics(robot, robot.body(id_body).child);
end
    