module sm_alu
(
    input  [31:0] srcA,       
    input  [31:0] srcB,       
    input  [ 3:0] oper,       
    input  [ 4:0] shift,      
    output        sign,       
    output reg [31:0] result  
);
    always @ (*) begin
        case (oper) 
            default     : result = srcA + srcB; 
            `ALU_ADD    : result = srcA + srcB; 
            `ALU_OR     : result = srcA | srcB; 
            `ALU_AND    : result = srcA & srcB; 
            `ALU_LUI    : result = (srcB << 16); 
            `ALU_SRL    : result = srcB >> shift; 
            `ALU_SRLV   : result = srcB >> srcA; 
            `ALU_SLTU   : result = (srcA < srcB) ? 1 : 0; 
            `ALU_SUBU   : result = srcA - srcB; 
            `ALU_NOR    : result = ~(srcA | srcB); 
            `ALU_NOTNEG : result = srcB >=0; 
        endcase
    end
    assign sign = (result == 0);
endmodule 