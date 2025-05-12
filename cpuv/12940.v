module lm32_shifter (
    clk_i,
    rst_i,
    stall_x,
    direction_x,
    sign_extend_x,
    operand_0_x,
    operand_1_x,
    shifter_result_m
);
input clk_i;                                
input rst_i;                                
input stall_x;                              
input direction_x;                          
input sign_extend_x;                        
input [`LM32_WORD_RNG] operand_0_x;         
input [`LM32_WORD_RNG] operand_1_x;         
output [`LM32_WORD_RNG] shifter_result_m;   
wire   [`LM32_WORD_RNG] shifter_result_m;   
reg direction_m;                            
reg [`LM32_WORD_RNG] left_shift_result;     
reg [`LM32_WORD_RNG] right_shift_result;    
reg [`LM32_WORD_RNG] left_shift_operand;    
wire [`LM32_WORD_RNG] right_shift_operand;  
wire fill_value;                            
wire [`LM32_WORD_RNG] right_shift_in;       
integer shift_idx_0;                        
integer shift_idx_1;                        
always @(*)
begin
    for (shift_idx_0 = 0; shift_idx_0 < `LM32_WORD_WIDTH; shift_idx_0 = shift_idx_0 + 1)
        left_shift_operand[`LM32_WORD_WIDTH-1-shift_idx_0] = operand_0_x[shift_idx_0];
end
assign right_shift_operand = direction_x == `LM32_SHIFT_OP_LEFT ? left_shift_operand : operand_0_x;
assign fill_value = (sign_extend_x == `TRUE) && (direction_x == `LM32_SHIFT_OP_RIGHT)
                      ? operand_0_x[`LM32_WORD_WIDTH-1]
                      : 1'b0;
assign right_shift_in = {`LM32_WORD_WIDTH{fill_value}};
always @(*)
begin
    for (shift_idx_1 = 0; shift_idx_1 < `LM32_WORD_WIDTH; shift_idx_1 = shift_idx_1 + 1)
        left_shift_result[`LM32_WORD_WIDTH-1-shift_idx_1] = right_shift_result[shift_idx_1];
end
assign shifter_result_m = direction_m == `LM32_SHIFT_OP_LEFT ? left_shift_result : right_shift_result;
always @(posedge clk_i `CFG_RESET_SENSITIVITY)
begin
    if (rst_i == `TRUE) 
    begin
        right_shift_result <= {`LM32_WORD_WIDTH{1'b0}}; 
        direction_m <= `FALSE;                          
    end
    else 
    begin
        if (stall_x == `FALSE) 
        begin
            right_shift_result <= {right_shift_in, right_shift_operand} >> operand_1_x[`LM32_SHIFT_RNG];
            direction_m <= direction_x;
        end
    end
end
endmodule