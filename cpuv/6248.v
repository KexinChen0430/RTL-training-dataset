module assert_transition_assume (clk, reset_n, start_state, next_state, test_expr, xzcheck_enable);
       parameter width = 8;
       input clk, reset_n;
       input [width-1:0] test_expr, start_state, next_state;
       input  xzcheck_enable;
endmodule