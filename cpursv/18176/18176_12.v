
module counter  #(parameter  N = 1, M = 1)
  (input  wire clk,
   input  wire reset,
   output wire max_tck,
   output wire [N-1:0] q);

  reg  [N-1:0] x;
  wire [N-1:0] x_n;

  
  always @(posedge clk)
      if (reset) x <= 0;
      else x <= x_n;
  assign x_n = (x == (M-1)) ? 0 : (1+x);
  assign q = x;
  assign max_tck = (x == (M-1)) ? 1'b1 : 1'b0;
endmodule

