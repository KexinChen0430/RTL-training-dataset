
module oh_pll  #(parameter  N = 8)
  (input  clkin,
   input  nreset,
   input  clkfb,
   input  pll_en,
   input  [(8*N)-1:0] clkdiv,
   input  [(N*16)-1:0] clkphase,
   input  [7:0] clkmult,
   output [(0-1)+N:0] clkout,
   output locked);


endmodule

