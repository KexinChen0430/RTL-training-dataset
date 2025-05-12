module
output	[width-1:0]		muxout;         
output	[width-1:0]		muxreg;         
reg	[width-1:0]		muxout;         
reg	[width-1:0]		muxreg;         
always @(muxin_a or muxin_b or muxin_c or muxin_d or rfwb_op) begin 
`ifdef pippo_ADDITIONAL_SYNOPSYS_DIRECTIVES
	case(rfwb_op[`RFWBOP_WIDTH-1:2]) 
`else
	case(rfwb_op[`RFWBOP_WIDTH-1:2]) 
`endif
		2'b00: begin
		    muxout = muxin_a; 
		end
		2'b01: begin
			muxout = muxin_b; 
		end
		2'b10: begin
			muxout = muxin_c; 
		end
		2'b11: begin
			muxout = muxin_d; 
		end
	endcase
end
always @(posedge clk or posedge rst) begin 
	if (rst) begin
		muxreg <= #1 32'd0; 
	end
	else if (!wb_freeze) begin
		muxreg <= #1 muxout; 
	end
end
endmodule