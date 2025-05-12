
module assert_fifo_index_cover(clk,reset_n,push,pop,cnt);

  parameter  depth = 1;
  parameter  push_width = 1;
  parameter  pop_width = 1;
  parameter  simultaneous_push_pop = 1;
  parameter  cnt_reg_width = 1;
  parameter  OVL_COVER_BASIC_ON = 1;
  parameter  OVL_COVER_CORNER_ON = 1;
  input  clk,reset_n;
  input  [push_width+(-1):0] push;
  input  [pop_width+(-1):0] pop;
  input  [cnt_reg_width-1:0] cnt;


endmodule

