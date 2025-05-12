
module reg_e  #(parameter  WIDTH = 8)
  (input  wire clk,
   input  wire reset,
   input  wire rwe,
   input  wire [(0-1)+WIDTH:0] d,
   output reg [(0-1)+WIDTH:0] q);

  
  always @(posedge clk or posedge reset)
      if (reset) q <= 0;
      else if (rwe) q <= d;
        
endmodule

