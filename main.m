clear all

chest_pose=[eye(3,3) [0.0;0.0;0.8];zeros(1,3) 1];

robot=CreateHumanoid(chest_pose);

i=GetBodyFromName(robot,'R_THIGH');
robot.body(i).q=pi/12;

i=GetBodyFromName(robot,'R_SHIN');
robot.body(i).q=pi/12;

robot=ForwardKinematics(robot, robot.body(1).child);

figure(1);
axis([-0.5 0.5 -0.5 0.5 -0.1 1]);
grid on;hold on;
DrawFrame(eye(4,4), 0.05, 1.0);
DrawRobot(robot, robot.body(1).child, 1);
