module execute_jump(
    input wire iCLOCK,                  
    input wire inRESET,                 
    input wire iRESET_SYNC,             
    input wire iEVENT_HOLD,             
    input wire iEVENT_START,            
    input wire iEVENT_IRQ_FRONT2BACK,   
    input wire iEVENT_IRQ_BACK2FRONT,   
    input wire iEVENT_END,              
    input wire iSTATE_NORMAL,           
    input wire iPREV_VALID,             
    input wire iPREV_EX_BRANCH,         
    input wire iPREV_EX_SYS_REG,        
    input wire [31:0] iPREV_PC,         
    input wire iPREV_BRANCH_PREDICT_ENA,
    input wire iPREV_BRANCH_PREDICT_HIT,
    input wire iPREV_BRANCH_NORMAL_JUMP_INST, 
    input wire iPREV_BRANCH_PREDICT_MISS_VALID,          
    input wire iPREV_BRANCH_PREDICT_ADDR_MISS_VALID,     
    input wire iPREV_BRANCH_IB_VALID,                    
    input wire [31:0] iPREV_BRANCH_ADDR,                 
    input wire iPREV_SYSREG_IDT_VALID,                   
    input wire iPREV_SYSREG_PDT_VALID,                   
    input wire iPREV_SYSREG_PSR_VALID,                   
    input wire [31:0] iPREV_SYSREG_ADDR,                 
    input wire iNEXT_BUSY,                               
    output wire oNEXT_PREDICT_ENA,                       
    output wire oNEXT_PREDICT_HIT,                       
    output wire oNEXT_JUMP_VALID,                        
    output wire [31:0] oNEXT_JUMP_ADDR,                  
    output wire oNEXT_NORMAL_JUMP_INST,                  
    output wire oNEXT_TYPE_BRANCH_VALID,                 
    output wire oNEXT_TYPE_BRANCH_IB_VALID,              
    output wire oNEXT_TYPE_SYSREG_IDT_VALID,             
    output wire oNEXT_TYPE_SYSREG_PDT_VALID,             
    output wire oNEXT_TYPE_SYSREG_PSR_VALID              
);
wire jump_condition = iPREV_BRANCH_PREDICT_MISS_VALID || iPREV_BRANCH_PREDICT_ADDR_MISS_VALID;
reg b_predict_ena;
reg b_predict_hit;
reg b_jump_valid;
always@(posedge iCLOCK or negedge inRESET)begin
    if(!inRESET)begin
        b_predict_ena <= 1'b0;
        b_predict_hit <= 1'b0;
        b_jump_valid <= 1'b0;
    end
    else if(iRESET_SYNC || iEVENT_HOLD || iEVENT_END)begin
        b_predict_ena <= 1'b0;
        b_predict_hit <= 1'b0;
        b_jump_valid <= 1'b0;
    end
    else begin
        if(iSTATE_NORMAL)begin
            if(!iNEXT_BUSY)begin
                if(iPREV_VALID && iPREV_EX_BRANCH)begin
                    b_predict_ena <= iPREV_BRANCH_PREDICT_ENA;
                    b_predict_hit <= iPREV_BRANCH_PREDICT_HIT;
                    b_jump_valid <= jump_condition;
                end
                else begin
                    b_predict_ena <= 1'b0;
                    b_predict_hit <= 1'b0;
                    b_jump_valid <= 1'b0;
                end
            end
        end
        else begin
            b_predict_ena <= 1'b0;
            b_predict_hit <= 1'b0;
            b_jump_valid <= 1'b0;
        end
    end
end
reg [31:0] b_jump_addr;
always@(posedge iCLOCK or negedge inRESET)begin
    if(!inRESET)begin
        b_jump_addr <= 32'h0;
    end
    else if(iRESET_SYNC || iEVENT_HOLD || iEVENT_END)begin
        b_jump_addr <= 32'h0;
    end
    else begin
        if(iSTATE_NORMAL)begin
            if(!iNEXT_BUSY)begin
                if(iPREV_VALID)begin
                    if(iPREV_EX_BRANCH)begin
                        if(iPREV_BRANCH_PREDICT_ADDR_MISS_VALID || iPREV_BRANCH_IB_VALID)begin
                            b_jump_addr <= iPREV_BRANCH_ADDR;
                        end
                        else if(iPREV_BRANCH_PREDICT_MISS_VALID)begin
                            b_jump_addr <= iPREV_PC;
                        end
                    end
                    else if(iPREV_EX_SYS_REG) begin
                        b_jump_addr <= iPREV_SYSREG_ADDR;
                    end
                end
                else begin
                    b_jump_addr <= 32'h0;
                end
            end
        end
        else begin
            b_jump_addr <= 32'h0;
        end
    end
end
reg b_branch_normal_valid;
reg b_branch_ib_valid;
reg b_sysreg_idt_valid;
reg b_sysreg_pdt_valid;
reg b_sysreg_psr_valid;
always@(posedge iCLOCK or negedge inRESET)begin
    if(!inRESET)begin
        b_branch_normal_valid <= 1'b0;
        b_branch_ib_valid <= 1'b0;
        b_sysreg_idt_valid <= 1'b0;
        b_sysreg_pdt_valid <= 1'b0;
        b_sysreg_psr_valid <= 1'b0;
    end
    else if(iRESET_SYNC || iEVENT_HOLD || iEVENT_END)begin
        b_branch_normal_valid <= 1'b0;
        b_branch_ib_valid <= 1'b0;
        b_sysreg_idt_valid <= 1'b0;
        b_sysreg_pdt_valid <= 1'b0;
        b_sysreg_psr_valid <= 1'b0;
    end
    else begin
        if(iSTATE_NORMAL)begin
            if(!iNEXT_BUSY)begin
                if(iPREV_VALID && iPREV_EX_BRANCH)begin
                    b_branch_normal_valid <= iPREV_BRANCH_PREDICT_MISS_VALID || iPREV_BRANCH_PREDICT_ADDR_MISS_VALID;
                    b_branch_ib_valid <= iPREV_BRANCH_IB_VALID;
                end
                else begin
                    b_branch_normal_valid <= 1'b0;
                    b_branch_ib_valid <= 1'b0;
                end
                if(iPREV_VALID && iPREV_EX_SYS_REG)begin
                    b_sysreg_idt_valid <= iPREV_SYSREG_IDT_VALID;
                    b_sysreg_pdt_valid <= iPREV_SYSREG_PDT_VALID;
                    b_sysreg_psr_valid <= iPREV_SYSREG_PSR_VALID;
                end
                else begin
                    b_sysreg_idt_valid <= 1'b0;
                    b_sysreg_pdt_valid <= 1'b0;
                    b_sysreg_psr_valid <= 1'b0;
                end
            end
        end
        else begin
            b_branch_normal_valid <= 1'b0;
            b_branch_ib_valid <= 1'b0;
            b_sysreg_idt_valid <= 1'b0;
            b_sysreg_pdt_valid <= 1'b0;
            b_sysreg_psr_valid <= 1'b0;
        end
    end
end
reg b_branch_normal_jump_inst;
always@(posedge iCLOCK or negedge inRESET)begin
    if(!inRESET)begin
        b_branch_normal_jump_inst <= 1'b0;
    end
    else if(iRESET_SYNC || iEVENT_HOLD || iEVENT_END)begin
        b_branch_normal_jump_inst <= 1'b0;
    end
    else begin
        if(iSTATE_NORMAL)begin
            if(!iNEXT_BUSY)begin
                if(iPREV_VALID && iPREV_EX_BRANCH)begin
                    b_branch_normal_jump_inst <= iPREV_BRANCH_NORMAL_JUMP_INST;
                end
                else begin
                    b_branch_normal_jump_inst <= 1'b0;
                end
            end
        end
        else begin
            b_branch_normal_jump_inst <= 1'b0;
        end
    end
end
assign oNEXT_PREDICT_ENA = b_predict_ena;
assign oNEXT_PREDICT_HIT = b_predict_hit;
assign oNEXT_JUMP_VALID = b_jump_valid;
assign oNEXT_JUMP_ADDR  = b_jump_addr;
assign oNEXT_NORMAL_JUMP_INST = b_branch_normal_jump_inst;
assign oNEXT_TYPE_BRANCH_VALID = b_branch_normal_valid;
assign oNEXT_TYPE_BRANCH_IB_VALID = b_branch_ib_valid;
assign oNEXT_TYPE_SYSREG_IDT_VALID = b_sysreg_idt_valid;
assign oNEXT_TYPE_SYSREG_PDT_VALID = b_sysreg_pdt_valid;
assign oNEXT_TYPE_SYSREG_PSR_VALID = b_sysreg_psr_valid;
endmodule