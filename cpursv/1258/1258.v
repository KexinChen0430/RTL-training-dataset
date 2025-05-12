
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(rst,wr_clk,rd_clk,din,wr_en,rd_en,dout,full,empty,
                                                 rd_data_count,wr_data_count,prog_full,prog_empty);

  input  rst;
  input  wr_clk;
  input  rd_clk;
  input  [63:0] din;
  input  wr_en;
  input  rd_en;
  output [63:0] dout;
  output full;
  output empty;
  output [9:0] rd_data_count;
  output [9:0] wr_data_count;
  output prog_full;
  output prog_empty;


endmodule

