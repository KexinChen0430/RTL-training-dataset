module assert_one_cold_assume (clk, reset_n, test_expr, xzcheck_enable, inactive_val);
       parameter width = 8;
       parameter inactive = `OVL_ONE_COLD;
       input clk, reset_n, xzcheck_enable, inactive_val;
       input [width-1:0] test_expr;
endmodule