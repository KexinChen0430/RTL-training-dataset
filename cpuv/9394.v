module flt_recip_iter
(
input	 clk, 
input [7:0]	 X0, 
input [31:0]	 denom, 
output reg [31:0] recip 
);