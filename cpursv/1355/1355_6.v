
module assert_unchange_assume(clk,reset_n,start_event,test_expr,window,ignore_new_start,
                              reset_on_new_start,error_on_new_start,xzcheck_enable);

  parameter  width = 8;
  parameter  num_cks = 1+1;
  input  clk;
  input  reset_n;
  input  start_event;
  input  window;
  input  ignore_new_start;
  input  reset_on_new_start;
  input  error_on_new_start;
  input  [(-1)+width:0] test_expr;
  input  xzcheck_enable;


endmodule

