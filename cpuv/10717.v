module qm_control(
    input wire [5:0] i_Opcode,       
    input wire [5:0] i_Function,     
    output reg co_RegDest,           
    output reg co_ALUSource,         
    output reg [3:0] co_ALUControl,  
    output reg co_MemWrite,          
    output reg co_RegWSource,        
    output reg co_RegWrite,          
    output reg co_Branch             
);
always @(i_Opcode, i_Function) begin
    case (i_Opcode) 
        `OP_SPECIAL: begin 
            co_RegDest = 1;       
            co_ALUSource = 0;     
            co_MemWrite = 0;      
            co_RegWSource = 0;    
            co_RegWrite = 1;      
            co_Branch = 0;        
            case (i_Function)
                `FUNCT_ADD: co_ALUControl = `ALU_ADD;
                `FUNCT_ADDU: co_ALUControl = `ALU_ADD;
                `FUNCT_AND: co_ALUControl = `ALU_AND;
                `FUNCT_DIV: co_ALUControl = `ALU_DIV;
                `FUNCT_DIVU: co_ALUControl = `ALU_DIV;
                `FUNCT_MULT: co_ALUControl = `ALU_MUL;
                `FUNCT_MULTU: co_ALUControl = `ALU_MUL;
                `FUNCT_NOR: co_ALUControl = `ALU_NOR;
                `FUNCT_OR: co_ALUControl = `ALU_OR;
                `FUNCT_SLT: co_ALUControl = `ALU_SLT;
                `FUNCT_SUB: co_ALUControl = `ALU_SUB;
                `FUNCT_SUBU: co_ALUControl = `ALU_SUB;
                `FUNCT_XOR: co_ALUControl = `ALU_XOR;
            endcase
        end
        `OP_LW: begin 
            co_RegDest = 0;       
            co_ALUSource = 1;     
            co_ALUControl = 0;    
            co_MemWrite = 0;      
            co_RegWSource = 1;    
            co_RegWrite = 1;      
            co_Branch = 0;        
        end
        `OP_SW: begin 
            co_RegDest = 0;       
            co_ALUSource = 1;     
            co_ALUControl = 0;    
            co_MemWrite = 1;      
            co_RegWSource = 0;    
            co_RegWrite = 0;      
            co_Branch = 0;        
        end
        6'b001???: 
        begin
            co_RegDest = 0;       
            co_ALUSource = 1;     
            co_MemWrite = 0;      
            co_RegWSource = 0;    
            co_RegWrite = 1;      
            co_Branch = 0;        
            case (i_Opcode)
                `OP_ADDI: co_ALUControl = `ALU_ADD;
                `OP_ADDIU: co_ALUControl = `ALU_ADD;
                `OP_ANDI: co_ALUControl = `ALU_AND;
                `OP_ORI: co_ALUControl = `ALU_OR;
                `OP_XORI: co_ALUControl = `ALU_XOR;
                `OP_SLTI: co_ALUControl = `ALU_SLT;
                `OP_SLTIU: co_ALUControl = `ALU_SLT;
            endcase
        end
        default: begin 
            co_RegDest = 0;
            co_ALUSource = 1;
            co_MemWrite = 0;
            co_RegWSource = 0;
            co_RegWrite = 0;
            co_Branch = 0;
            co_ALUControl = 0;
        end
    endcase
end
endmodule