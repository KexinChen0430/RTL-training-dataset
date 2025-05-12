module mbus_wire_ctrl(
	input RESETn,                 
	input DOUT_FROM_BUS,          
	input CLKOUT_FROM_BUS,        
	`ifdef POWER_GATING           
	input DIN,                    
	input CLKIN,                  
	input RELEASE_ISO_FROM_SLEEP_CTRL, 
	input EXTERNAL_INT,           
	`endif
	output reg DOUT,              
	output reg CLKOUT             
);
`ifdef POWER_GATING
always @ * 
begin
	if (~RESETn) 
		CLKOUT <= `SD 1'b1; 
	else if (RELEASE_ISO_FROM_SLEEP_CTRL==`IO_HOLD) 
		CLKOUT <= `SD CLKIN; 
	else
		CLKOUT <= `SD CLKOUT_FROM_BUS; 
	if (~RESETn) 
		DOUT <= `SD 1'b1; 
	else if (EXTERNAL_INT) 
		DOUT <= `SD 0; 
	else
	begin
		if (RELEASE_ISO_FROM_SLEEP_CTRL==`IO_HOLD) 
			DOUT <= `SD DIN; 
		else
			DOUT <= `SD DOUT_FROM_BUS; 
	end
end
`else 
always @ * 
begin
	if (~RESETn) 
		CLKOUT <= `SD 1'b1; 
	else
		CLKOUT <= `SD CLKOUT_FROM_BUS; 
	if (~RESETn) 
		DOUT <= `SD 1'b1; 
	else
		DOUT <= `SD DOUT_FROM_BUS; 
end
`endif
endmodule 