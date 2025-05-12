module MISO_DDR_phase_selector(
	input wire [3:0] 		phase_select,	
	input wire [73:0] 	MISO4x,			
	output reg [15:0] 	MISO				
	);
	always @(*) begin 
		case (phase_select) 
			0:       MISO <= {MISO4x[2],  MISO4x[6],  MISO4x[10], MISO4x[14], MISO4x[18], MISO4x[22], MISO4x[26], MISO4x[30], MISO4x[34], MISO4x[38], MISO4x[42], MISO4x[46], MISO4x[50], MISO4x[54], MISO4x[58], MISO4x[62]}; 
		endcase
	end
endmodule