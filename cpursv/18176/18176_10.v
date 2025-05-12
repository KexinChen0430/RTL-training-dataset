
module counter  #(parameter  N = 1, M = 1)
  (input  wire clk,
   input  wire reset,
   output wire max_tck,
   output wire [(0-1)+N:0] q);

  reg  [(0-1)+N:0] x;
  wire [(0-1)+N:0] x_n;

  
  always @(posedge clk)
      if (reset) x <= 0;
      else x <= x_n;
  assign x_n = (x == ((0-1)+M)) ? 0 : (1+x);
  assign q = x;
  assign max_tck = (x == ((0-1)+M)) ? 1'b1 : 1'b0;
endmodule

