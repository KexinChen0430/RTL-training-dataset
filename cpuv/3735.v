module assert_zero_one_hot_assert (
    clk,            
    reset_n,        
    test_expr,      
    xzcheck_enable  
);
    parameter width = 1;
    input clk;
    input reset_n;
    input xzcheck_enable;
    input [width-1:0] test_expr;
endmodule