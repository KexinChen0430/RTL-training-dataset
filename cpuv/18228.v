module CC_ODDR #( 
	parameter [0:0] CLK_INV = 1'b0 
)(
	input D0, 
	input D1, 
	(* clkbuf_sink *) 
	input CLK, 
	(* clkbuf_sink *) 
	input DDR, 
	output Q 
);
	wire clk; 
	assign clk = (CLK_INV) ? ~CLK : CLK; 
	reg q0, q1; 
	assign Q = (DDR) ? q0 : q1; 
	always @(posedge clk) 
	begin
		q0 <= D0; 
	end
	always @(negedge clk) 
	begin
		q1 <= D1; 
	end
endmodule 