module sm_control
(
    input      [5:0] cmdOper,     
    input      [5:0] cmdFunk,     
    input            aluZero,     
    output           pcSrc,       
    output reg       regDst,      
    output reg       regWrite,    
    output reg       aluSrc,      
    output reg [2:0] aluControl   
);
    reg          branch;         
    reg          condZero;       
    assign pcSrc = branch & (aluZero == condZero);
    always @ (*) begin
        branch      = 1'b0;       
        condZero    = 1'b0;       
        regDst      = 1'b0;       
        regWrite    = 1'b0;       
        aluSrc      = 1'b0;       
        aluControl  = `ALU_ADD;   
        casez( {cmdOper,cmdFunk} )
            default               : ;
            { `C_SPEC,  `F_ADDU } : begin regDst = 1'b1; regWrite = 1'b1; aluControl = `ALU_ADD;  end
            { `C_SPEC,  `F_OR   } : begin regDst = 1'b1; regWrite = 1'b1; aluControl = `ALU_OR;   end
            { `C_SPEC,  `F_SRL  } : begin regDst = 1'b1; regWrite = 1'b1; aluControl = `ALU_SRL;  end
            { `C_SPEC,  `F_SLTU } : begin regDst = 1'b1; regWrite = 1'b1; aluControl = `ALU_SLTU; end
            { `C_SPEC,  `F_SUBU } : begin regDst = 1'b1; regWrite = 1'b1; aluControl = `ALU_SUBU; end
            { `C_ADDIU, `F_ANY  } : begin regWrite = 1'b1; aluSrc = 1'b1; aluControl = `ALU_ADD;  end
            { `C_LUI,   `F_ANY  } : begin regWrite = 1'b1; aluSrc = 1'b1; aluControl = `ALU_LUI;  end
            { `C_BEQ,   `F_ANY  } : begin branch = 1'b1; condZero = 1'b1; aluControl = `ALU_SUBU; end
            { `C_BNE,   `F_ANY  } : begin branch = 1'b1; aluControl = `ALU_SUBU; end
        endcase
    end
endmodule