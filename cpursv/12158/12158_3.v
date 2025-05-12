
module flop  #(parameter  WIDTH = 32)
  (input  clk,
   input  [(-1)+WIDTH:0] d,
   output reg [(-1)+WIDTH:0] q);

  
  always @(posedge clk)  q <= d;
endmodule

