module assert_next_cover (clk, reset_n, test_expr, start_event, no_overlapping);
       parameter OVL_COVER_BASIC_ON = 1;
       parameter OVL_COVER_CORNER_ON = 1;
       input clk, reset_n, test_expr, start_event, no_overlapping;
endmodule