module mbus_addr_rf(
	input		RESETn, 
	`ifdef POWER_GATING 
	input		RELEASE_ISO_FROM_SLEEP_CTRL, 
	`endif
	output	reg	[`DYNA_WIDTH-1:0] ADDR_OUT, 
	input		[`DYNA_WIDTH-1:0] ADDR_IN, 
	output	reg	ADDR_VALID, 
	input		ADDR_WR_EN, 
	input		ADDR_CLRn 
);
wire	RESETn_local = (RESETn & ADDR_CLRn);
`ifdef POWER_GATING 
wire	ADDR_UPDATE = (ADDR_WR_EN & (~RELEASE_ISO_FROM_SLEEP_CTRL));
`else
wire	ADDR_UPDATE = ADDR_WR_EN;
`endif
always @ (posedge ADDR_UPDATE or negedge RESETn_local)
begin
	if (~RESETn_local) 
	begin
		ADDR_OUT <= {`DYNA_WIDTH{1'b1}}; 
		ADDR_VALID <= 0; 
	end
	else 
	begin
		ADDR_OUT <= ADDR_IN; 
		ADDR_VALID <= 1; 
	end
end
endmodule 