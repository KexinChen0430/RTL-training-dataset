module assert_never_unknown_assume (clk, reset_n, qualifier, test_expr, xzcheck_enable);
       parameter width = 8;
       input clk, reset_n, qualifier, xzcheck_enable;
       input [width-1:0] test_expr;
endmodule