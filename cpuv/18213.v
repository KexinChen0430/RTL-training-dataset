module CC_IDDR #( 
	parameter [0:0] CLK_INV = 1'b0 
)(
	input D, 
	(* clkbuf_sink *) 
	input CLK, 
	output reg Q0, Q1 
);
	wire clk; 
	assign clk = (CLK_INV) ? ~CLK : CLK; 
	always @(posedge clk) 
	begin
		Q0 <= D; 
	end
	always @(negedge clk) 
	begin
		Q1 <= D; 
	end
endmodule 