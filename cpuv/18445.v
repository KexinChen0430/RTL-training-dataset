module or1200_reg2mem(addr, lsu_op, regdata, memdata);
parameter width = `OR1200_OPERAND_WIDTH; 
input	[1:0]			addr; 
input	[`OR1200_LSUOP_WIDTH-1:0]	lsu_op; 
input	[width-1:0]		regdata; 
output	[width-1:0]		memdata; 
reg	[7:0]			memdata_hh; 
reg	[7:0]			memdata_hl; 
reg	[7:0]			memdata_lh; 
reg	[7:0]			memdata_ll; 
assign memdata = {memdata_hh, memdata_hl, memdata_lh, memdata_ll}; 
always @(lsu_op or addr or regdata) begin 
	casez({lsu_op, addr[1:0]})	
		{`OR1200_LSUOP_SB, 2'b00} : memdata_hh = regdata[7:0]; 
		{`OR1200_LSUOP_SH, 2'b00} : memdata_hh = regdata[15:8]; 
		default : memdata_hh = regdata[31:24]; 
	endcase
end
always @(lsu_op or addr or regdata) begin 
	casez({lsu_op, addr[1:0]})	
		{`OR1200_LSUOP_SW, 2'b00} : memdata_hl = regdata[23:16]; 
		default : memdata_hl = regdata[7:0]; 
	endcase
end
always @(lsu_op or addr or regdata) begin 
	casez({lsu_op, addr[1:0]})	
		{`OR1200_LSUOP_SB, 2'b10} : memdata_lh = regdata[7:0]; 
		default : memdata_lh = regdata[15:8]; 
	endcase
end
always @(regdata) 
	memdata_ll = regdata[7:0]; 
endmodule