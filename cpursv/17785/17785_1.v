
module rx_fifo(rst,wr_clk,rd_clk,din,wr_en,rd_en,dout,full,empty,
               rd_data_count);

  input  rst;
  input  wr_clk;
  input  rd_clk;
  input  [7:0] din;
  input  wr_en;
  input  rd_en;
  output [63:0] dout;
  output full;
  output empty;
  output [7:0] rd_data_count;


endmodule

