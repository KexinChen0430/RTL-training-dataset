module dff(clk, d, q);
input clk, d;
output reg q;
always @(posedge clk)
	q <= d;
endmodule