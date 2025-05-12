module command_selector ( 
	input wire [5:0] 		channel, 
	input wire				DSP_settle, 
	input wire [15:0] 	aux_cmd, 
	input wire				digout_override, 
	output reg [15:0] 	MOSI_cmd 
	);
	always @(*) begin 
		case (channel) 
			0:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle }; 
			32:		MOSI_cmd <= (aux_cmd[15:8] == 8'h83) ? {aux_cmd[15:1], digout_override} : aux_cmd; 
			default: MOSI_cmd <= 16'b0; 
			endcase 
	end 
endmodule 