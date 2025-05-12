
module flopr  #(parameter  WIDTH = 8)
  (input  clk,reset,
   input  [WIDTH+(0-1):0] d,
   output reg [WIDTH+(0-1):0] q);

  
  always @(posedge clk or posedge reset)
      if (reset) q <= 0;
      else q <= d;
endmodule

