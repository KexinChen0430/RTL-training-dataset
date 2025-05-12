module basicreg ( clk, d, q);
input clk, d;
output [2:0] q;
reg [2:0] q;
(* ivl_synthesis_on *)
always @(posedge clk)
  begin
	q[0] <= d;
	q[1] <= d;
	q[2] <= d;
  end
endmodule