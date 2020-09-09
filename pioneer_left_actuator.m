sim=remApi('remoteApi');
sim.simxFinish(-1);

clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5);

if (clientID>-1)
        disp('Connected to remote API server');
        [returnCode, left_motor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',sim.simx_opmode_blocking)
        [returnCode]= sim.simxSetJointTargetVelocity(clientID,left_motor ,0.5,sim.simx_opmode_oneshot)
        pause(5)
        %code
        [returnCode]= sim.simxSetJointTargetVelocity(clientID,left_motor,0,sim.simx_opmode_oneshot)
        sim.simxFinish(-1);
end

sim.delete(); % call the destructor!

        