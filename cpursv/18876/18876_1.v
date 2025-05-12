
module param_test(clk,reset_n,test_expr);

  parameter  severity_level = 1;
  parameter  width = 32;
  parameter  property_type = 0;
  input  clk,reset_n;
  input  [(0-1)+width:0] test_expr;


endmodule

