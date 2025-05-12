
module LFSR  #(parameter  WIDTH = 16, POLY = 16'hD008)
  (input  rst,
   input  clk,
   input  [WIDTH+(-1):0] seed,
   output reg [WIDTH+(-1):0] r);

  wire  feedback = ^(POLY & r);

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            r <= seed;
          end
        else 
          begin
            r <= {r[WIDTH+(0-1<<<1):0],feedback};
          end
      end
endmodule

