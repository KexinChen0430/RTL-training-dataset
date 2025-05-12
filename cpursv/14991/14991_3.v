
module assert_increment_cover(clk,reset_n,test_expr);

  parameter  width = 8;
  parameter  OVL_COVER_BASIC_ON = 1;
  input  clk;
  input  reset_n;
  input  [width+(0-1):0] test_expr;


endmodule

