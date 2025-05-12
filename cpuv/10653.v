module mbus_ext_int( 
	input	CLKIN, 
	input	RESETn, 
	input	REQ_INT, 
	input	BUS_BUSYn, 
	input	BC_PWR_ON, 
	input	LC_PWR_ON, 
	output 	reg EXTERNAL_INT_TO_WIRE, 
	output	reg EXTERNAL_INT_TO_BUS, 
	input	CLR_EXT_INT 
);
wire RESETn_local = (RESETn & CLKIN); 
wire RESETn_local2 = (RESETn & (~CLR_EXT_INT)); 
wire INT_BUSY = (REQ_INT & BUS_BUSYn); 
always @ (posedge INT_BUSY or negedge RESETn_local) 
begin
	if (~RESETn_local) 
		EXTERNAL_INT_TO_WIRE <= 0; 
	else
	begin
		case ({BC_PWR_ON, LC_PWR_ON}) 
			{`IO_HOLD, `IO_HOLD}: begin EXTERNAL_INT_TO_WIRE <= 1; end 
			{`IO_RELEASE, `IO_HOLD}: begin if (BUS_BUSYn) EXTERNAL_INT_TO_WIRE <= 1; end 
			default: begin end 
		endcase
	end
end
always @ (posedge INT_BUSY or negedge RESETn_local2) 
begin
	if (~RESETn_local2) 
		EXTERNAL_INT_TO_BUS <= 0; 
	else
	begin
		case ({BC_PWR_ON, LC_PWR_ON}) 
			{`IO_HOLD, `IO_HOLD}: begin EXTERNAL_INT_TO_BUS <= 1; end 
			{`IO_RELEASE, `IO_HOLD}: begin if (BUS_BUSYn) EXTERNAL_INT_TO_BUS <= 1; end 
			default: begin end 
		endcase
	end
end
endmodule 