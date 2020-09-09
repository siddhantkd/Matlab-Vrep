sim=remApi('remoteApi');
sim.simxFinish(-1);

clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5);

if (clientID>-1)
        disp('Connected to remote API server');
        %Handle
        [returnCode, left_motor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',sim.simx_opmode_blocking);
        [returnCode, front_sensor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor6',sim.simx_opmode_blocking);
        
        %code
        [returnCode]= sim.simxSetJointTargetVelocity(clientID,left_motor ,0.5,sim.simx_opmode_oneshot);
        [returnCode, detectionState,detectedPoint,~, ~]=sim.simxReadProximitySensor(clientID,front_sensor,sim.simx_opmode_streaming);
        for i =1:50
            [returnCode, detectionState,detectedPoint,~, ~]=sim.simxReadProximitySensor(clientID,front_sensor,sim.simx_opmode_buffer);
            disp(norm(detectedPoint));
            pause(0.1)
        end
        [returnCode]= sim.simxSetJointTargetVelocity(clientID,left_motor,0,sim.simx_opmode_oneshot);
        sim.simxFinish(-1);
end

sim.delete(); % call the destructor!

        