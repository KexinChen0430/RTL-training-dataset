
module flopen  #(parameter  WIDTH = 32)
  (input  clk,
   input  en,
   input  [(0-1)+WIDTH:0] d,
   output reg [(0-1)+WIDTH:0] q);

  
  always @(posedge clk)  if (en) q <= d;
    
endmodule

