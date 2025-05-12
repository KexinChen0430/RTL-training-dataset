module FB_InjectorMotorController
(
		input wire clk, 
		input wire InjectorArmFinishedMovement_eI, 
		input wire EmergencyStopChanged_eI, 
		input wire ConveyorStoppedForInject_eI, 
		input wire PumpFinished_eI, 
		output wire StartPump_eO, 
		output wire InjectDone_eO, 
		output wire InjectorPositionChanged_eO, 
		output wire InjectRunning_eO, 
		input wire  EmergencyStop_I, 
		output reg [7:0] InjectorPosition_O , 
		input reset 
);