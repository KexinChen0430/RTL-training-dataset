
module oh_pll  #(parameter  N = 8)
  (input  clkin,
   input  nreset,
   input  clkfb,
   input  pll_en,
   input  [(8*N)+(-1):0] clkdiv,
   input  [(-1)+(N*16):0] clkphase,
   input  [7:0] clkmult,
   output [N+(-1):0] clkout,
   output locked);


endmodule

