
module LFSR  #(parameter  WIDTH = 16, POLY = 16'hD008)
  (input  rst,
   input  clk,
   input  [(0-1)+WIDTH:0] seed,
   output reg [(0-1)+WIDTH:0] r);

  wire  feedback = ^(POLY & r);

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            r <= seed;
          end
        else 
          begin
            r <= {r[WIDTH-2:0],feedback};
          end
      end
endmodule

