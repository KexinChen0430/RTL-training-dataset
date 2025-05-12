module body
always@(seli or a or b or alu or mac or rnd)
	case(seli) 
		2'b00: sel_r = a;
		2'b01: sel_r = b;
		2'b10: sel_r = alu;
		2'b11: sel_r = rnd ? (mac + 16'h8000) & 40'hffffff0000 : mac;
	endcase
assign iovf = 1'b1;
always@(iovf or ovm or sel_r)
	if (ovm & iovf)
		if (sel_r[39]) 
			iresult = 40'hff80000000;
		else             
			iresult = 40'h007fffffff;
	else
			iresult = sel_r;
assign bp_result = iresult;
always@(posedge clk)
	if (ena & we)
		result <= iresult;
always@(posedge clk)
	if (ena & we)
		begin
			ovf <= iovf;
			zf  <= ~|iresult;
		end
endmodule