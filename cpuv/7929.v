module fsm(input clk, U, S, D, 
	output reg countUp, reg paused 
	);
	 reg [3:0] state = countingUp, next_state; 
	 parameter countingUp = 4'b0000, countingDown = 4'b0001, pausedUp = 4'b0010, pausedDown = 4'b0011,
					pausingUp = 4'b0100, unpausingUp = 4'b0101, pausingDown = 4'b0110, unpausingDown = 4'b0111,
					upDownPressed = 4'b1000, downUpPressed = 4'b1001, upPausedDownPressed = 4'b1010, downPausedUpPressed = 4'b1011;
	always @(posedge clk) 
        state <= next_state; 
	always @(*) 
	begin
		case(state) 
			countingUp:				next_state <= (S==1) ? pausingUp			: (D==1) ? upDownPressed : countingUp;
			upDownPressed:			next_state <= (D==0) ? countingDown		: upDownPressed;
			pausingUp:				next_state <= (S==0) ? pausedUp			: pausingUp;
			pausedUp:				next_state <= (S==1) ? unpausingUp		: (D==1) ? upPausedDownPressed : pausedUp;
			unpausingUp:			next_state <= (S==0) ? countingUp		: unpausingUp;
			upPausedDownPressed:	next_state <= (D==0) ? pausedDown		: upPausedDownPressed;
			pausedDown:				next_state <= (S==1) ? unpausingDown	: (U==1) ? downPausedUpPressed : pausedDown;
			downPausedUpPressed:	next_state <= (U==0) ? pausedUp			: downPausedUpPressed;
			unpausingDown:			next_state <= (S==0) ? countingDown		: unpausingDown;
			countingDown:			next_state <= (S==1) ? pausingDown		: (U==1) ? downUpPressed : countingDown;
			pausingDown:			next_state <= (S==0) ? pausedDown		: pausingDown;
			downUpPressed:			next_state <= (U==0) ? countingUp		: downUpPressed;
			default:					next_state <= countingUp; 
		endcase
	end
	reg [1:0] outputs; 
    always @(*) 
		begin
			case (state) 
				countingUp:				outputs <= 2'b10;
				upDownPressed:			outputs <= 2'b10;
				pausingUp:				outputs <= 2'b11;
				pausedUp:				outputs <= 2'b11;
				unpausingUp:			outputs <= 2'b10;
				upPausedDownPressed:	outputs <= 2'b11;
				pausedDown:				outputs <= 2'b01;
				downPausedUpPressed:	outputs <= 2'b01;
				unpausingDown:			outputs <= 2'b00;
				countingDown:			outputs <= 2'b00;
				pausingDown:			outputs <= 2'b01;
				downUpPressed:			outputs <= 2'b00;
				default:					outputs <= 2'b10; 
		  endcase
		  countUp <= outputs[1]; 
		  paused <= outputs[0]; 
		end
endmodule 