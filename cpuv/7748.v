module assert_frame_assert (clk, reset_n, start_event, test_expr, win,
                            ignore_new_start, reset_on_new_start, error_on_new_start,
                            xzcheck_enable);
       parameter min_cks = 1;
       parameter max_cks = 2;
       input clk, reset_n, start_event, test_expr, win,
             ignore_new_start, reset_on_new_start, error_on_new_start,
             xzcheck_enable;
endmodule