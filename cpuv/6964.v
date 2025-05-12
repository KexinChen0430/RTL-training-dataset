module reset_logic(input [3:0] tens_digit, output reg module_reset); 
    always @(*) 
        module_reset <= (tens_digit == 4'h6); 
endmodule 