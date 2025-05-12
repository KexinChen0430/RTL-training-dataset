module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, rst, din, wr_en, rd_en, dout, full, almost_full, empty)
;
  input clk;
  input rst;
  input [64:0]din;
  input wr_en;
  input rd_en;
  output [64:0]dout;
  output full;
  output almost_full;
  output empty;
endmodule