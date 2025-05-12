module assert_next_assert (clk, reset_n, test_expr, start_event, no_overlapping, xzcheck_enable);
       parameter num_cks = 1;
       parameter check_overlapping = 1;
       parameter check_missing_start = 1;
       input clk, reset_n, test_expr, start_event, no_overlapping, xzcheck_enable;
endmodule