
module scfifo_24in_24out_12kb(clk,rst,din,wr_en,rd_en,dout,full,empty,data_count);

  input  clk;
  input  rst;
  input  [23:0] din;
  input  wr_en;
  input  rd_en;
  output [23:0] dout;
  output full;
  output empty;
  output data_count;


endmodule

