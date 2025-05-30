
module flopenr  #(parameter  WIDTH = 32)
  (input  clk,reset,en,
   input  [(-1)+WIDTH:0] d,
   output reg [(-1)+WIDTH:0] q);

  
  always @(posedge clk)
      if (reset) q <= 0;
      else if (en) q <= d;
        
endmodule

