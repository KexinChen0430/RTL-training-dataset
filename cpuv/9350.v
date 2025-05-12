module assert_no_transition_assert (clk, reset_n, test_expr, start_state, next_state, xzcheck_enable); 
       parameter width = 1; 
       input clk, reset_n; 
       input [(width-1):0] test_expr, start_state, next_state; 
       input xzcheck_enable; 
endmodule 