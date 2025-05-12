
module flopenr  #(parameter  WIDTH = 8)
  (input  clk,reset,
   input  en,
   input  [(-1)+WIDTH:0] d,
   output reg [(-1)+WIDTH:0] q);

  
  always @(posedge clk or posedge reset)
      if (reset) q <= 0;
      else if (en) q <= d;
        
endmodule

