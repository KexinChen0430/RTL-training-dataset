module assert_odd_parity_assert (clk, reset_n, test_expr, xzcheck_enable);
       parameter width = 1;
       input clk, reset_n;
       input [width-1:0] test_expr;
       input xzcheck_enable;
endmodule