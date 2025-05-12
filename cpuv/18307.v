module CC_OBUF #(
	parameter PIN_NAME = "UNPLACED", 
	parameter V_IO = "UNDEFINED", 
	parameter DRIVE = "UNDEFINED", 
	parameter SLEW = "UNDEFINED", 
	parameter [3:0] DELAY_OBF = 1'bx, 
	parameter [0:0] FF_OBF = 1'bx 
)(
	input  A, 
	(* iopad_external_pin *) 
	output O 
);
	assign O = A;
endmodule 