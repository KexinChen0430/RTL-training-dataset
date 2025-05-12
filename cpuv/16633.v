module lm32_logic_op (
    logic_op_x,         
    operand_0_x,        
    operand_1_x,        
    logic_result_x      
    );
input [`LM32_LOGIC_OP_RNG] logic_op_x;       
input [`LM32_WORD_RNG] operand_0_x;          
input [`LM32_WORD_RNG] operand_1_x;          
output [`LM32_WORD_RNG] logic_result_x;      
reg    [`LM32_WORD_RNG] logic_result_x;      
integer logic_idx;                           
always @(*)
begin
    for(logic_idx = 0; logic_idx < `LM32_WORD_WIDTH; logic_idx = logic_idx + 1)
        logic_result_x[logic_idx] = logic_op_x[{operand_1_x[logic_idx], operand_0_x[logic_idx]}];
end
endmodule