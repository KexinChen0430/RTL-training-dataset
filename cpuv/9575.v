module robs_control_unit_fsm( 
	input clk, reset, 
	input zq, zy, zr, 
	output c0, c1, c2, c3, c9, c10, c5, c8, c12, c14, c13, c4, c6, c7, c11, 
	output reg done 
	);
	parameter   S0  	= 5'b00000; 
	reg [4:0]  state, nextstate; 
	reg [14:0] controls; 
	always @(posedge clk or posedge reset)
	 if (reset) state <= S0; 
	 else state <= nextstate; 
	always @( * )
	 case(state)
	 endcase
	assign {c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0} = controls;
	always @( * )
	 case(state)
	 endcase
endmodule