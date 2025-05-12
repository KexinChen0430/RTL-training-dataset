module assert_no_overflow_assume (clk, reset_n, test_expr, xzcheck_enable);
       parameter width = 8;
       parameter min = 0;
       parameter max = 1;
       input clk, reset_n;
       input [width-1:0] test_expr;
       input xzcheck_enable;
endmodule