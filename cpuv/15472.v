module lm32_multiplier (
    clk_i,
    rst_i,
    stall_x,
    stall_m,
    operand_0,
    operand_1,
    result
    );
input clk_i;                            
input rst_i;                            
input stall_x;                          
input stall_m;                          
input [`LM32_WORD_RNG] operand_0;       
input [`LM32_WORD_RNG] operand_1;       
output [`LM32_WORD_RNG] result;         
reg    [`LM32_WORD_RNG] result;         
reg [`LM32_WORD_RNG] muliplicand;       
reg [`LM32_WORD_RNG] multiplier;        
reg [`LM32_WORD_RNG] product;           
always @(posedge clk_i `CFG_RESET_SENSITIVITY) 
begin
    if (rst_i == `TRUE)                  
    begin
        muliplicand <= {`LM32_WORD_WIDTH{1'b0}}; 
        multiplier <= {`LM32_WORD_WIDTH{1'b0}};  
        product <= {`LM32_WORD_WIDTH{1'b0}};     
        result <= {`LM32_WORD_WIDTH{1'b0}};      
    end
    else                                 
    begin
        if (stall_x == `FALSE)           
        begin
            muliplicand <= operand_0;    
            multiplier <= operand_1;     
        end
        if (stall_m == `FALSE)           
            product <= muliplicand * multiplier; 
        result <= product;               
    end
end
endmodule