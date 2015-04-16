function robot=CreateHumanoid(chest_pose)
%
%  function robot=CreateHumanoid(pose)
%
%  Create the humanoid structure
%
% Inputs: 
%  chest_pose: 4x4 homogeneous matrix containing the pose of the chest in the
%  world frame
%
% Outputs:
% robot: data strcture of the robot
%
%


l_hip=0.1;

h_chest=0.25;
h_thigh=0.25;
h_shin=0.2;
h_zmp=0.1;

i=1;
robot.body(i).name='CHEST';
robot.body(i).father=[];
robot.body(i).child=['R_HIP';'L_HIP'];
robot.body(i).Tabs=chest_pose;

% RIGHT
i=i+1;
robot.body(i).name='R_HIP';
robot.body(i).father=['CHEST'];
robot.body(i).child=['R_THIGH'];
robot.body(i).a=[1.0;0.0;0.0];
robot.body(i).b=[0.0;l_hip;-h_chest];
robot.body(i).q=0.0;

i=i+1;
robot.body(i).name='R_THIGH';
robot.body(i).father=['R_HIP'];
robot.body(i).child=['R_SHIN'];
robot.body(i).a=[0.0;1.0;0.0];
robot.body(i).b=[0.0;0.0;0.0];
robot.body(i).q=0.0;

i=i+1;
robot.body(i).name='R_SHIN';
robot.body(i).father=['R_THIGH'];
robot.body(i).child=['R_FOOT'];
robot.body(i).a=[0.0;1.0;0.0];
robot.body(i).b=[0.0;0.0;-h_thigh];
robot.body(i).q=0.0;

i=i+1;
robot.body(i).name='R_FOOT';
robot.body(i).father=['R_SHIN'];
robot.body(i).child=[];
robot.body(i).a=[0.0;1.0;0.0];
robot.body(i).b=[0.0;0.0;-h_shin];
robot.body(i).q=0.0;

% LEFT
i=i+1;
robot.body(i).name='L_HIP';
robot.body(i).father=['CHEST'];
robot.body(i).child=['L_THIGH'];
robot.body(i).a=[1.0;0.0;0.0];
robot.body(i).b=[0.0;-l_hip;-h_chest];
robot.body(i).q=0.0;

i=i+1;
robot.body(i).name='L_THIGH';
robot.body(i).father=['L_HIP'];
robot.body(i).child=['L_SHIN'];
robot.body(i).a=[0.0;1.0;0.0];
robot.body(i).b=[0.0;0.0;0.0];
robot.body(i).q=0.0;

i=i+1;
robot.body(i).name='L_SHIN';
robot.body(i).father=['L_THIGH'];
robot.body(i).child=['L_FOOT'];
robot.body(i).a=[0.0;1.0;0.0];
robot.body(i).b=[0.0;0.0;-h_thigh];
robot.body(i).q=0.0;

i=i+1;
robot.body(i).name='L_FOOT';
robot.body(i).father=['L_SHIN'];
robot.body(i).child=[];
robot.body(i).a=[0.0;1.0;0.0];
robot.body(i).b=[0.0;0.0;-h_shin];
robot.body(i).q=0.0;

robot.h_zmp=h_zmp;
robot.nbody=i;

