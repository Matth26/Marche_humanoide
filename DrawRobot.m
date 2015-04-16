function DrawRobot(robot, listofbody, option)
%
%
%  function DrawRobot(robot, flag)
%
%  Draw the robot in 3D
%
% Inputs:
%  robot : data structure of the robot
%  option :     1 --> draw the joint and the frame
%               2 --> draw the joint
%               otherwise : don't draw the joint
%

if isempty(listofbody),
    return;
end

[n,m]=size(listofbody);
fflag=0;
s=0.05;


for i=1:n,
    id_body=GetBodyFromName(robot, listofbody(i,:));
    id_father=GetBodyFromName(robot, robot.body(id_body).father(1,:));
    p0=robot.body(id_father).Tabs(1:3,4);
    
    % Draw the chest
    if ((isempty(robot.body(id_father).father) ==1) && (fflag ==0)),
        DrawFrame(robot.body(id_father).Tabs,s, 1.0);
        p=p0+robot.body(id_father).Tabs(1:3,3)*0.2;
        xx(1)=p0(1);yy(1)=p0(2);zz(1)=p0(3);
        xx(2)=p(1);yy(2)=p(2);zz(2)=p(3);
        plot3(xx, yy, zz,'b', 'LineWidth',2.0);
        fflag=1;
    end
    
    % Draw the joint
    switch option,
        case 1,
            DrawRJoint(robot.body(id_body).Tabs, robot.body(id_body).a, 1, s);
        case 2,
            DrawRJoint(robot.body(id_body).Tabs, robot.body(id_body).a, 0, s);
        otherwise,
    end
    
    % Draw the segment associated with the body
    p=robot.body(id_body).Tabs(1:3,4);
    xx(1)=p0(1);yy(1)=p0(2);zz(1)=p0(3);
    xx(2)=p(1);yy(2)=p(2);zz(2)=p(3);
    plot3(xx, yy, zz,'b', 'LineWidth',2.0);
    
    if strcmp(robot.body(id_body).name, 'R_FOOT'),
        T=robot.body(id_body).Tabs;
        p0=T(1:3,4);
        xx(1)=p0(1);yy(1)=p0(2);zz(1)=p0(3);
        xx(2)=robot.r_zmp(1);yy(2)=robot.r_zmp(2);zz(2)=robot.r_zmp(3);
        plot3(xx, yy, zz,'b', 'LineWidth',2.0);
        T(1:3,4)=robot.r_zmp;
        DrawFoot(T);
    end
    
    if strcmp(robot.body(id_body).name, 'L_FOOT'),
        T=robot.body(id_body).Tabs;
        p0=T(1:3,4);
        xx(1)=p0(1);yy(1)=p0(2);zz(1)=p0(3);
        xx(2)=robot.l_zmp(1);yy(2)=robot.l_zmp(2);zz(2)=robot.l_zmp(3);
        plot3(xx, yy, zz,'b', 'LineWidth',2.0);
        T(1:3,4)=robot.l_zmp;
        DrawFoot(T);
    end
    
    DrawRobot(robot, robot.body(id_body).child, option);
   
end
    


