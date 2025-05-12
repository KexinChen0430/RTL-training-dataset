module flt_int 
	(
	input	      	clk, 
	input	[31:0]	afl, 
	output reg	[31:0]	fl 
	);
reg	[22:0]	mask_1; 
reg	[31:0]	afl_1; 
always @(posedge clk)
	begin
		afl_1 <= afl; 
		casex(afl[30:23]) 
		8'b1000_0000:mask_1 <= 23'b10000000000000000000000;
		8'b1000_0001:mask_1 <= 23'b11000000000000000000000;
		default: mask_1 <= 23'b11111111111111111111111; 
		endcase
	end
always @(posedge clk)
	begin
		if(afl_1[30]) fl <= {afl_1[31:23],(mask_1 & afl_1[22:0])};
		else if(&afl_1[29:23]) fl <= {afl_1[31:23],23'h0};
		else fl <= 0;
	end
endmodule 