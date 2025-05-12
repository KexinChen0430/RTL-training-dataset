module l5 (input [7:0] a, output [7:0] z `PUBLIC); 
`INLINE_MODULE 
parameter PARAM = 5; 
wire [7:0] z0 `PUBLIC; wire [7:0] z1 `PUBLIC; 
assign z = a; 
endmodule 