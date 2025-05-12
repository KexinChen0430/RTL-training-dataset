
module flopen  #(parameter  WIDTH = 32)
  (input  clk,
   input  en,
   input  [WIDTH+(0-1):0] d,
   output reg [WIDTH+(0-1):0] q);

  
  always @(posedge clk)  if (en) q <= d;
    
endmodule

