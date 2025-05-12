module fifo_async_104x32(wr_clk, wr_rst, rd_clk, rd_rst, din, wr_en, rd_en, dout, full, almost_full, empty, valid, prog_full)
;
  input wr_clk;
  input wr_rst;
  input rd_clk;
  input rd_rst;
  input [103:0]din;
  input wr_en;
  input rd_en;
  output [103:0]dout;
  output full;
  output almost_full;
  output empty;
  output valid;
  output prog_full;
endmodule