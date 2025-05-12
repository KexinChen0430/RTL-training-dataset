
module assert_win_unchange_assert(clk,reset_n,start_event,end_event,test_expr,window,
                                  xzdetect_test_expr,xzcheck_enable);

  parameter  width = 8;
  input  clk;
  input  reset_n;
  input  start_event;
  input  end_event;
  input  window;
  input  [width+(0-1):0] test_expr;
  input  xzdetect_test_expr;
  input  xzcheck_enable;


endmodule

