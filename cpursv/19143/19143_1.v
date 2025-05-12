
module SoftInt(i_wb_clk,i_wb_rst,i_wb_stb,i_wb_cyc,i_wb_we,i_wb_adr,
               i_wb_dat,o_wb_ack,o_wb_dat);

  input  i_wb_clk;
  input  i_wb_rst;
  input  i_wb_stb;
  input  i_wb_cyc;
  input  i_wb_we;
  input  [31:0] i_wb_adr;
  input  [31:0] i_wb_dat;
  output o_wb_ack;
  output [31:0] o_wb_dat;


endmodule

