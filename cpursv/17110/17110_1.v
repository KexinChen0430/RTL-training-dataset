
module dcfifo_32in_32out_8kb_cnt(rst,wr_clk,rd_clk,din,wr_en,rd_en,dout,full,empty,
                                 rd_data_count);

  input  rst;
  input  wr_clk;
  input  rd_clk;
  input  [31:0] din;
  input  wr_en;
  input  rd_en;
  output [31:0] dout;
  output full;
  output empty;
  output rd_data_count;


endmodule

