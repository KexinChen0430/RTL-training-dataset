
module oh_pll  #(parameter  N = 8)
  (input  clkin,
   input  nreset,
   input  clkfb,
   input  pll_en,
   input  [(N*8)+(0-1):0] clkdiv,
   input  [(0-1)+(16*N):0] clkphase,
   input  [7:0] clkmult,
   output [(0-1)+N:0] clkout,
   output locked);


endmodule

