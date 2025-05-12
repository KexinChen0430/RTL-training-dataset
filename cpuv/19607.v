module basicreg ( clk, d, q);
input clk, d;
output q;
reg q;
(* ivl_synthesis_on *)
always @(posedge clk)
	q <= d;
endmodule