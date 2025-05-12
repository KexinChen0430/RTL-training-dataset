
module assert_range_cover(clk,reset_n,test_expr);

  parameter  width = 8;
  parameter  min = 1;
  parameter  max = 2;
  parameter  OVL_COVER_SANITY_ON = 1;
  parameter  OVL_COVER_CORNER_ON = 1;
  input  clk,reset_n;
  input  [width-1:0] test_expr;


endmodule

