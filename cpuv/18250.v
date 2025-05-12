module CC_LVDS_OBUF #( 
	parameter PIN_NAME_P = "UNPLACED", 
	parameter PIN_NAME_N = "UNPLACED", 
	parameter V_IO = "UNDEFINED", 
	parameter [0:0] LVDS_BOOST = 1'bx, 
	parameter [3:0] DELAY_OBF = 1'bx, 
	parameter [0:0] FF_OBF = 1'bx 
)(
	input  A, 
	(* iopad_external_pin *) 
	output OP, ON 
);
	assign OP = A; 
	assign ON = ~A; 
endmodule 