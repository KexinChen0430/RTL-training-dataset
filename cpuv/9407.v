module pcie_recv_fifo(clk, srst, din, wr_en, rd_en, dout, full, empty)
;
  input clk;
  input srst;
  input [127:0]din;
  input wr_en;
  input rd_en;
  output [127:0]dout;
  output full;
  output empty;
endmodule