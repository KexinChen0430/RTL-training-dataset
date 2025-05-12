module assert_never_unknown_cover (clk, reset_n, qualifier, test_expr); 
       parameter width = 8; 
       parameter OVL_COVER_SANITY_ON = 1; 
       parameter OVL_COVER_BASIC_ON = 1; 
       input clk, reset_n, qualifier; 
       input [width-1:0] test_expr; 
endmodule 