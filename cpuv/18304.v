module CC_LVDS_IBUF #(
	parameter PIN_NAME_P = "UNPLACED", 
	parameter PIN_NAME_N = "UNPLACED", 
	parameter V_IO = "UNDEFINED",       
	parameter [0:0] LVDS_RTERM = 1'bx, 
	parameter [3:0] DELAY_IBF = 1'bx,  
	parameter [0:0] FF_IBF = 1'bx      
)(
	(* iopad_external_pin *)            
	input  IP, IN,                      
	output Y                            
);
	assign Y = IP;                      
endmodule