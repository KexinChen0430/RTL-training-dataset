module mbus_busy_ctrl(
	input	CLKIN,
	input	RESETn,
	input	BC_RELEASE_ISO,
	input	SC_CLR_BUSY,
	input	MBUS_CLR_BUSY,
	output	reg BUS_BUSYn);
reg	clr_busy_temp;
always @ *
begin
	if (BC_RELEASE_ISO==`IO_HOLD)
		clr_busy_temp = 0;
	else
		clr_busy_temp = MBUS_CLR_BUSY;
end
wire RESETn_BUSY = ((~clr_busy_temp) & (~SC_CLR_BUSY));
always @ (negedge CLKIN or negedge RESETn or negedge RESETn_BUSY)
begin
	if (~RESETn)
		BUS_BUSYn <= 1;
	else if (~CLKIN)
		BUS_BUSYn <= 0;
	else
		BUS_BUSYn <= 1;
end
endmodule