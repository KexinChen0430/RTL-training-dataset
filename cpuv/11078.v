module qm_alu(
    input wire [3:0] i_ALUControl,  
    input wire [31:0] i_A,          
    input wire [31:0] i_B,          
    output reg [31:0] o_Result,     
    always @(i_ALUControl, i_A, i_B) begin 
        case (i_ALUControl) 
            `ALU_ADD: o_Result = i_A + i_B; 
            `ALU_AND: o_Result = i_A & i_B; 
            `ALU_OR:  o_Result = i_A | i_B; 
            `ALU_XOR: o_Result = i_A ^ i_B; 
            `ALU_SLT: o_Result = i_A << i_B; 
            `ALU_SUB: o_Result = i_A - i_B; 
            `ALU_DIV: o_Result = i_A / i_B; 
            `ALU_MUL: o_Result = i_A * i_B; 
            `ALU_NOR: o_Result = ~(i_A | i_B); 
        endcase 
    end 
); 