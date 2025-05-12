module assert_width_cover (clk, reset_n, test_expr);
       parameter min_cks = 1;
       parameter max_cks = 2;
       parameter OVL_COVER_BASIC_ON = 1;
       parameter OVL_COVER_CORNER_ON = 1;
       input clk, reset_n, test_expr;
endmodule