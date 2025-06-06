module mbus_master_wire_ctrl(
	input RESETn, 
	input DOUT_FROM_BUS, 
	input CLKOUT_FROM_BUS, 
	input RELEASE_ISO_FROM_SLEEP_CTRL, 
	output reg DOUT, 
	output reg CLKOUT, 
	input EXTERNAL_INT 
);
always @ *
begin
	if( !RESETn )
		CLKOUT <= #1 1'b1;
	else if (RELEASE_ISO_FROM_SLEEP_CTRL==`IO_HOLD)
		CLKOUT <= #1 1'b1;
	else
		CLKOUT <= #1 CLKOUT_FROM_BUS;
	if ( !RESETn )
		DOUT <= #1 1'b1;
	else if (EXTERNAL_INT)
	begin
		DOUT <= #1 0;
	end
	else
	begin
		if (RELEASE_ISO_FROM_SLEEP_CTRL==`IO_HOLD)
		begin
			DOUT <= #1 1'b1;
		end
		else
		begin
			DOUT <= #1 DOUT_FROM_BUS;
		end
	end
end
endmodule