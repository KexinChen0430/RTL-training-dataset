module assert_no_transition_cover (clk, reset_n, test_expr, start_state);
       parameter width = 1;
       parameter OVL_COVER_BASIC_ON = 1;
       input clk, reset_n;
       input [(width-1):0] test_expr, start_state;
endmodule