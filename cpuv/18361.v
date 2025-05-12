module CC_TOBUF #( 
	parameter PIN_NAME = "UNPLACED", 
	parameter V_IO = "UNDEFINED", 
	parameter DRIVE = "UNDEFINED", 
	parameter SLEW = "UNDEFINED", 
	parameter [0:0] PULLUP = 1'bx, 
	parameter [0:0] PULLDOWN = 1'bx, 
	parameter [0:0] KEEPER = 1'bx, 
	parameter [3:0] DELAY_OBF = 1'bx, 
	parameter [0:0] FF_OBF = 1'bx 
)(
	input  A, T, 
	(* iopad_external_pin *)
	output O 
);
	assign O = T ? 1'bz : A; 
endmodule 