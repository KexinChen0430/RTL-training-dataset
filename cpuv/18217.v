module CC_LVDS_IOBUF #(
	parameter PIN_NAME_P = "UNPLACED", 
	parameter PIN_NAME_N = "UNPLACED", 
	parameter V_IO = "UNDEFINED", 
	parameter [0:0] LVDS_RTERM = 1'bx, 
	parameter [0:0] LVDS_BOOST = 1'bx, 
	parameter [3:0] DELAY_IBF = 1'bx, 
	parameter [3:0] DELAY_OBF = 1'bx, 
	parameter [0:0] FF_IBF = 1'bx, 
	parameter [0:0] FF_OBF = 1'bx 
)(
	input  A, T, 
	(* iopad_external_pin *) 
	inout  IOP, ION, 
	output Y 
);
	assign IOP = T ? 1'bz :  A;
	assign ION = T ? 1'bz : ~A;
	assign Y = IOP;
endmodule 