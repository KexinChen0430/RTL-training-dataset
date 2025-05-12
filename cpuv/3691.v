module assert_zero_one_hot_cover (
    clk,                
    reset_n,            
    test_expr,          
    all_one_hots_checked 
);
    parameter width = 1; 
    parameter OVL_COVER_SANITY_ON = 1; 
    parameter OVL_COVER_CORNER_ON = 1; 
    input clk; 
    input reset_n; 
    input all_one_hots_checked; 
    input [width-1:0] test_expr; 
endmodule 