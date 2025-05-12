
module tx_axis_gen(clk,rst,din,wr_en,rd_en,dout,full,almost_full,empty);

  input  clk;
  input  rst;
  input  [64:0] din;
  input  wr_en;
  input  rd_en;
  output [64:0] dout;
  output full;
  output almost_full;
  output empty;


endmodule

