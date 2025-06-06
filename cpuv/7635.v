module ALUdec(
  input [6:0]       opcode,          
  input [2:0]       funct,           
  input             add_rshift_type, 
  output reg [4:0]  ALUop            
);
  always @(*) begin
    case (opcode)                     
      `OPC_LUI: ALUop = `ALU_COPY_B;  
      `OPC_AUIPC, `OPC_LOAD, `OPC_STORE, `OPC_JAL, `OPC_JALR:
        ALUop = `ALU_ADD;             
      `OPC_BRANCH:
        case (funct)                  
          `FNC_BEQ: ALUop = `ALU_EQ;  
          `FNC_BNE: ALUop = `ALU_NE;  
          `FNC_BLT: ALUop = `ALU_LT;  
          `FNC_BGE: ALUop = `ALU_GE;  
          `FNC_BLTU: ALUop = `ALU_LTU;
          `FNC_BGEU: ALUop = `ALU_GEU;
          default: ALUop = `ALU_COPY_B;
        endcase
      `OPC_ARI_ITYPE:
        case (funct)                  
          `FNC_ADD_SUB: ALUop = `ALU_ADD; 
          `FNC_SLT: ALUop = `ALU_SLT; 
          `FNC_SLTU: ALUop = `ALU_SLTU;
          `FNC_XOR: ALUop = `ALU_XOR; 
          `FNC_OR: ALUop = `ALU_OR;   
          `FNC_AND: ALUop = `ALU_AND; 
          `FNC_SLL: ALUop = `ALU_SLL; 
          `FNC_SRL_SRA: ALUop = add_rshift_type == `FNC2_SRL ? `ALU_SRL : `ALU_SRA;
        endcase
      `OPC_ARI_RTYPE:
        case (funct)                  
          `FNC_ADD_SUB: ALUop = add_rshift_type == `FNC2_ADD ? `ALU_ADD : `ALU_SUB;
          `FNC_SLL: ALUop = `ALU_SLL; 
          `FNC_SLT: ALUop = `ALU_SLT; 
          `FNC_SLTU: ALUop = `ALU_SLTU;
          `FNC_XOR: ALUop = `ALU_XOR; 
          `FNC_SRL_SRA: ALUop = add_rshift_type == `FNC2_SRL ? `ALU_SRL : `ALU_SRA;
          `FNC_OR: ALUop = `ALU_OR;   
          `FNC_AND: ALUop = `ALU_AND; 
          default: ALUop = `ALU_COPY_B;
        endcase
      default: ALUop = `ALU_COPY_B;   
    endcase
  end
endmodule