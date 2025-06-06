module assert_range_assume (clk, reset_n, test_expr, xzcheck_enable);
       parameter width = 8;
       parameter max = 2;
       parameter min = 1;
       input clk;
       input reset_n;
       input [width-1:0] test_expr;
       input xzcheck_enable;
endmodule