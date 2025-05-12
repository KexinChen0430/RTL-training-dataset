module GpReg(
    clk,        
    isWrD,      
    isQwD,      
    idRegD,     
    dataD,      
    idReg1,     
    data1,      
    idReg2,     
    data2,      
    idReg3,     
    data3       
);
input clk;                  
input isWrD;                
input isQwD;                
input[6:0] idRegD;          
input[63:0] dataD;          
input[6:0] idReg1;          
input[6:0] idReg2;          
input[6:0] idReg3;          
output[63:0] data1;         
output[63:0] data2;         
output[63:0] data3;         
reg[31:0] regs_lo[64];      
reg[31:0] regs_hi[64];      
reg[31:0] creg_lo[16];      
reg[31:0] creg_hi[16];      
reg[31:0] reg_pc;           
reg[31:0] reg_pr;           
reg[31:0] reg_sr;           
reg[5:0] tIdRegDLo;         
reg[5:0] tIdReg1Lo;         
reg[5:0] tIdReg2Lo;         
reg[5:0] tIdReg3Lo;         
always @ (clk) begin
    tIdRegDLo = idRegD[5:0];
    tIdReg1Lo = idReg1[5:0];
    tIdReg2Lo = idReg2[5:0];
    tIdReg3Lo = idReg3[5:0];
    if(idReg1[5:4]!=2'b01) begin
        if(idReg1[6]) begin
            data1[31: 0] = regs_hi[tIdReg1Lo];
            data1[63:32] = 32'h0000_0000;
        end else begin
            data1[31: 0] = regs_lo[tIdReg1Lo];
            data1[63:32] = regs_hi[tIdReg1Lo];
        end
    end else begin
        if(idReg1[6]) begin
            data1[31: 0] = creg_lo[tIdReg1Lo[3:0]];
            data1[63:32] = creg_hi[tIdReg1Lo[3:0]];
        end else begin
            data1[31: 0] = regs_lo[tIdReg1Lo];
            data1[63:32] = regs_hi[tIdReg1Lo];
        end
    end
    if(idReg2[5:4]!=2'b01) begin
        if(idReg2[6]) begin
            data2[31: 0] = regs_hi[tIdReg2Lo];
            data2[63:32] = 32'h0000_0000;
        end else begin
            data2[31: 0] = regs_lo[tIdReg2Lo];
            data2[63:32] = regs_hi[tIdReg2Lo];
        end
    end else begin
        if(idReg2[6]) begin
            data2[31: 0] = creg_lo[tIdReg2Lo[3:0]];
            data2[63:32] = creg_hi[tIdReg2Lo[3:0]];
        end else begin
            data2[31: 0] = regs_lo[tIdReg2Lo];
            data2[63:32] = regs_hi[tIdReg2Lo];
        end
    end
    if(idReg3[5:4]!=2'b01) begin
        if(idReg3[6]) begin
            data3[31: 0] = regs_hi[tIdReg3Lo];
            data3[63:32] = 32'h0000_0000;
        end else begin
            data3[31: 0] = regs_lo[tIdReg3Lo];
            data3[63:32] = regs_hi[tIdReg3Lo];
        end
    end else begin
        if(idReg3[6]) begin
            data3[31: 0] = creg_lo[tIdReg3Lo[3:0]];
            data3[63:32] = creg_hi[tIdReg3Lo[3:0]];
        end else begin
            data3[31: 0] = regs_lo[tIdReg3Lo];
            data3[63:32] = regs_hi[tIdReg3Lo];
        end
    end
end
always @ (posedge clk) begin
    if(isWrD==1'b1) begin
        if(idRegD[5:4]!=2'b01) begin
            if(isQwD==1'b1) begin
                $display("R[%X]Q=%X", tIdRegDLo, dataD);
                regs_lo[tIdRegDLo] <= dataD[31:0];
                regs_hi[tIdRegDLo] <= dataD[63:32];
            end else begin
                $display("R[%X]D=%X", tIdRegDLo, dataD);
                if(idRegD[6])
                    regs_hi[tIdRegDLo] <= dataD[31:0];
                else
                    regs_lo[tIdRegDLo] <= dataD[31:0];
            end
        end else begin
            $display("CSR[%X]=%X", tIdRegDLo, dataD);
            if(idRegD[6]) begin
                creg_lo[tIdRegDLo[3:0]] <= dataD[31:0];
                if(isQwD==1'b1)
                    creg_hi[tIdRegDLo[3:0]] <= dataD[63:32];
            end else begin
                regs_lo[tIdRegDLo] <= dataD[31:0];
                if(isQwD==1'b1)
                    regs_hi[tIdRegDLo] <= dataD[63:32];
            end
        end
    end
end
endmodule