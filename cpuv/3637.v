module assert_zero_one_hot_assume (clk, reset_n, test_expr, xzcheck_enable);
       parameter width = 1;
       input clk, reset_n, xzcheck_enable;
       input [width-1:0] test_expr;
endmodule