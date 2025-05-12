module CC_IBUF #(
	parameter PIN_NAME = "UNPLACED",          
	parameter V_IO = "UNDEFINED",             
	parameter [0:0] PULLUP = 1'bx,            
	parameter [0:0] PULLDOWN = 1'bx,          
	parameter [0:0] KEEPER = 1'bx,            
	parameter [0:0] SCHMITT_TRIGGER = 1'bx,   
	parameter [3:0] DELAY_IBF = 1'bx,         
	parameter [0:0] FF_IBF = 1'bx             
)(
	(* iopad_external_pin *))                 
	input  I,                                  
	output Y                                   
);
	assign Y = I;                              
endmodule