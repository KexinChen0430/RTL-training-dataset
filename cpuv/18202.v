module CC_IOBUF #(
	parameter PIN_NAME = "UNPLACED", 
	parameter V_IO = "UNDEFINED", 
	parameter DRIVE = "UNDEFINED", 
	parameter SLEW = "UNDEFINED", 
	parameter [0:0] PULLUP = 1'bx, 
	parameter [0:0] PULLDOWN = 1'bx, 
	parameter [0:0] KEEPER = 1'bx, 
	parameter [0:0] SCHMITT_TRIGGER = 1'bx, 
	parameter [3:0] DELAY_IBF = 1'bx, 
	parameter [3:0] DELAY_OBF = 1'bx, 
	parameter [0:0] FF_IBF = 1'bx, 
	parameter [0:0] FF_OBF = 1'bx 
)(
	input  A, T, 
	output Y, 
	(* iopad_external_pin *) 
	inout  IO 
);
	assign IO = T ? 1'bz : A;
	assign Y = IO;
endmodule 