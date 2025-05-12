
module assert_range_assert(clk,reset_n,test_expr,xzcheck_enable);

  parameter  width = 8;
  parameter  min = 1;
  parameter  max = 2;
  input  clk;
  input  reset_n;
  input  [width+(0-1):0] test_expr;
  input  xzcheck_enable;


endmodule

