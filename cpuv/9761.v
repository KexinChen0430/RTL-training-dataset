module assert_one_cold_cover (clk, reset_n, test_expr, one_colds_checked, inactive_val); 
       parameter width = 8; 
       parameter inactive = `OVL_ONE_COLD; 
       parameter OVL_COVER_SANITY_ON = 1; 
       parameter OVL_COVER_CORNER_ON = 1; 
       input clk, reset_n, inactive_val; 
       input [width-1:0] test_expr, one_colds_checked; 
endmodule 