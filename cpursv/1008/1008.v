
module fifo_async_103x32(rst,wr_clk,rd_clk,din,wr_en,rd_en,dout,full,empty,prog_full);

  input  rst;
  input  wr_clk;
  input  rd_clk;
  input  [102:0] din;
  input  wr_en;
  input  rd_en;
  output [102:0] dout;
  output full;
  output empty;
  output prog_full;


endmodule

