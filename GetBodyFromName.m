function id=GetBodyFromName(robot, name)
%
%
%  Get the body index of the robot from its name
%
%
%

for i=1:robot.nbody,
    if strcmp(robot.body(i).name, name) == 1,
        id=i;
        return;
    end
end
id=0;