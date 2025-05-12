
module registro  #(parameter  WIDTH = 8)
  (input  wire clk,
   input  wire reset,
   input  wire [(0-1)+WIDTH:0] d,
   output reg [(0-1)+WIDTH:0] q);

  
  always @(posedge clk or posedge reset)
      if (reset) q <= 0;
      else q <= d;
endmodule

