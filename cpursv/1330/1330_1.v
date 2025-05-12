
module assert_unchange_cover(clk,reset_n,start_event,window,reset_on_new_start,
                             window_close);

  parameter  OVL_COVER_BASIC_ON = 1;
  parameter  OVL_COVER_CORNER_ON = 1;
  input  clk;
  input  reset_n;
  input  start_event;
  input  window;
  input  reset_on_new_start;
  input  window_close;


endmodule

