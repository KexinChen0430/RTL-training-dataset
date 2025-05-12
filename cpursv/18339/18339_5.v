
module oh_pll  #(parameter  N = 8)
  (input  clkin,
   input  nreset,
   input  clkfb,
   input  pll_en,
   input  [(-1)+(N*8):0] clkdiv,
   input  [(-1)+(16*N):0] clkphase,
   input  [7:0] clkmult,
   output [N-1:0] clkout,
   output locked);


endmodule

