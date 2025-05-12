module ArithAlu(
    clk,        
    opMode,     
    srca,       
    srcb,       
    dst,        
    sri,        
    sro         
);
input           clk;
input[4:0]      opMode;
input[31:0]     srca;
input[31:0]     srcb;
output[31:0]    dst;
input[3:0]      sri;
output[3:0]     sro;
parameter[4:0] UOP_NONE     = 5'h00;
parameter[4:0] UOP_ADD      = 5'h01;
reg[31:0]  tDst;   
reg[5:0]   tShl;   
reg[3:0]   tSr;    
reg        tCvo;   
assign dst = tDst;
assign sro = tSr;
always @ (opMode) begin
    tSr = sri; 
    case(opMode)
        UOP_ADD: begin
            tDst = srca + srcb; 
        end
        UOP_SHL: begin
            tShl = srcb[5:0];      
            tDst = srca << tShl;   
        end
        UOP_ADDC: begin
            if(sri[0])
                tDst = srca + srcb + 1; 
            else
                tDst = srca + srcb;     
            tSr[0] = tDst[31] ^ srca[31]; 
        end
        UOP_TEST: begin
            tDst = srca & srcb;      
            tSr[3:2] = sri[3:2];    
            tSr[0] = (tDst == 0);   
        end
        default: begin
            tDst = 32'h0000_0000;   
            tSr = sri;              
        end
    endcase
end
endmodule