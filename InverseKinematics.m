function [qt, id, time, ept, eot]=InverseKinematics(robot, footname, targetW, Ts, eps_p, eps_o)
%
% function qt, ept, eot]=InverseKinematics(robot, footname, target, Ts, eps_p, eps_o)
%
%  Computes the inverse kinematics
%
%
% Inputs:
%  robot: data structure of the robot
%  footname : name of the target foot
%  target: desired pose for the foot (4x4 homogeneous matrix)
%  Ts: sample time
%  eps_p: error in position
%  eps_o: error in orientation
%
% Outputs : 
%   qt: computed set of joint position
%   id: index array to the joint
%   time: time ouptput
%   ept, eot : error in position and orientation
%


    KP=50.0*eye(3,3);
    KO=50.0*eye(3,3);
    Niter=100;
    
    switch strcmp(footname, 'R_FOOT'),
    case 1,
        id(1)=GetBodyFromName(robot, 'R_HIP');
        id(2)=GetBodyFromName(robot, 'R_THIGH');
        id(3)=GetBodyFromName(robot, 'R_SHIN');
        id(4)=GetBodyFromName(robot, 'R_FOOT');
        zmp=robot.r_zmp;
    case 0,
        id(1)=GetBodyFromName(robot, 'L_HIP');
        id(2)=GetBodyFromName(robot, 'L_THIGH');
        id(3)=GetBodyFromName(robot, 'L_SHIN');
        id(4)=GetBodyFromName(robot, 'L_FOOT');
        zmp=robot.l_zmp;
    otherwise,
        disp('Error in InverseKinematics: invalid argument footname');
        return;
    end
    
    
    % Transform to the chest
    TC=InverseMatrix(robot.body(1).Tabs);
    target=TC*targetW;
    
    q=zeros(4,1);
    for i=1:4,
        q(i)=robot.body(id(i)).q;
    end
    qt=q;
    time=[0.0];
    
    Sd=wedge(target(1:3,1));
    Nd=wedge(target(1:3,2));
    Ad=wedge(target(1:3,3));

    % Position error
    Pd=target(1:3,4);
    Pr=TC(1:3,1:3)*zmp + TC(1:3,4);
    ep=Pd - Pr;
    ep_norm=norm(ep);
    ept=ep_norm;
    
%    printf("ep_norm=%f\n",ep_norm);
    
    % Orientation error
    Ar=TC(1:3,1:3)*robot.body(id(4)).Tabs(1:3,1:3);
    eo=(cross(Ar(1:3,1), target(1:3,1)) + cross(Ar(1:3,2), target(1:3,2)) + cross(Ar(1:3,3), target(1:3,3)))/2.0;
    eo_norm=norm(eo);
%    printf("eo_norm=%f\n",eo_norm);
    eot=eo_norm;
    
    N=0;
    while ((N < Niter)&&((ep_norm > eps_p)||(eo_norm > eps_o))),
        Sr=wedge(Ar(1:3,1));
        Nr=wedge(Ar(1:3,2));
        Ar=wedge(Ar(1:3,3));
        L=-(Sd*Sr + Nd*Nr + Ad*Ar)/2.0;
        J=CalcJacobian(robot, footname);
        dq=pinv(J)*[KP*ep;pinv(L)*KO*eo];
        
        for i=1:4,
            robot.body(id(i)).q=robot.body(id(i)).q + dq(i)*Ts;
            q(i)=robot.body(id(i)).q;
        end
        qt=[qt q];
        time=[time (N+1)*Ts];
        
        robot=ForwardKinematics(robot,robot.body(1).child);
        
        switch strcmp(footname, 'R_FOOT'),
            case 1,
            zmp=robot.r_zmp;
        case 0,
            zmp=robot.l_zmp;
        otherwise,
            disp('Error in InverseKinematics: invalid argument footname');
            return;
        end
        
        Pr=TC(1:3,1:3)*zmp + TC(1:3,4);
        ep=Pd - Pr;
        ep_norm=norm(ep);
        ept=[ept ep_norm];
        
        Ar=TC(1:3,1:3)*robot.body(id(4)).Tabs(1:3,1:3);
        eo=(cross(Ar(1:3,1), target(1:3,1)) + cross(Ar(1:3,2), target(1:3,2)) + cross(Ar(1:3,3), target(1:3,3)))/2.0;
    
        eo_norm=norm(eo);
        eot=[eot eo_norm];
        N=N+1;
%        printf("ep_norm=%f\n",ep_norm);
%        printf("eo_norm=%f\n",eo_norm);
    end
