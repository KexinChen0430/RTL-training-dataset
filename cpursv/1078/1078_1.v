
module dcfifo_32in_32out_16kb(rst,wr_clk,rd_clk,din,wr_en,rd_en,dout,full,empty,
                              wr_data_count);

  input  rst;
  input  wr_clk;
  input  rd_clk;
  input  [31:0] din;
  input  wr_en;
  input  rd_en;
  output [31:0] dout;
  output full;
  output empty;
  output wr_data_count;


endmodule

