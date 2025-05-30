module pipeline_control_irq_return(
    input wire iCLOCK,                  
    input wire inRESET,                 
    input wire iRESET_SYNC,             
    input wire [31:0] iSYSREG_PPSR,     
    input wire [31:0] iSYSREG_SPR,      
    input wire [31:0] iSYSREG_TISR,     
    input wire [31:0] iSYSREG_TIDR,     
    input wire iRETURN_START,           
    output wire oFINISH,                
    output wire oFINISH_SPR_VALID,      
    output wire [31:0] oFINISH_SPR,     
    output wire oLDST_USE,              
    output wire oLDST_REQ,              
    input wire iLDST_BUSY,              
    output wire [1:0] oLDST_ORDER,      
    output wire oLDST_RW,               
    output wire [13:0] oLDST_ASID,      
    output wire [1:0] oLDST_MMUMOD,     
    output wire [31:0] oLDST_PDT,       
    output wire [31:0] oLDST_ADDR,      
    output wire [31:0] oLDST_DATA,      
    input wire iLDST_REQ,               
    input wire [31:0] iLDST_DATA        
);
wire spr_exchange_finish;               
wire [31:0] spr_exchange_spr;           
localparam PL_STT_IDLE = 2'h0;          
localparam PL_STT_SPR_EXCHANGE = 2'h1;  
localparam PL_STT_DONE = 2'h2;          
wire spr_exchange_condition = iSYSREG_PPSR[6:5] == `CORE_MODE_USER;
reg [1:0] state;                        
reg [1:0] b_state;                      
always@*begin
    case(b_state)
        PL_STT_IDLE:                    
            begin
                if(iRETURN_START)begin   
                    if(spr_exchange_condition)begin 
                        state = PL_STT_SPR_EXCHANGE; 
                    end
                    else begin           
                        state = PL_STT_DONE; 
                    end
                end
                else begin               
                    state = b_state;     
                end
            end
        PL_STT_SPR_EXCHANGE:             
            begin
                if(spr_exchange_finish)begin 
                    state = PL_STT_DONE; 
                end
                else begin               
                    state = b_state;     
                end
            end
        PL_STT_DONE:                     
            begin
                state = PL_STT_IDLE;     
            end
        default:                         
            begin
                state = PL_STT_IDLE;     
            end
    endcase 
end
always@(posedge iCLOCK or negedge inRESET)begin
    if(!inRESET)begin                   
        b_state <= PL_STT_IDLE;         
    end
    else if(iRESET_SYNC)begin           
        b_state <= PL_STT_IDLE;         
    end
    else begin                          
        b_state <= state;               
    end
end
reg b_finish;
always@(posedge iCLOCK or negedge inRESET)begin
    if(!inRESET)begin                   
        b_finish <= PL_STT_IDLE;        
    end
    else if(iRESET_SYNC)begin           
        b_finish <= PL_STT_IDLE;        
    end
    else begin                          
        b_finish <= state == PL_STT_DONE; 
    end
end
reg [1:0] b_state_delay;
always@(posedge iCLOCK or negedge inRESET)begin
    if(!inRESET)begin                   
        b_state_delay <= PL_STT_IDLE;   
    end
    else if(iRESET_SYNC)begin           
        b_state_delay <= PL_STT_IDLE;   
    end
    else begin                          
        b_state_delay <= b_state;       
    end
end
wire spr_excg_ldst_use;
wire spr_excg_ldst_req;
wire [1:0] spr_excg_ldst_order;
wire spr_excg_ldst_rw;
wire [13:0] spr_excg_ldst_asid;
wire [1:0] spr_excg_ldst_mmumod;
wire [31:0] spr_excg_ldst_pdt;
wire [31:0] spr_excg_ldst_addr;
wire [31:0] spr_excg_ldst_data;
pipeline_control_spr_exchange SPR_EXCHANGE(
    .iCLOCK(iCLOCK),
    .inRESET(inRESET),
    .iRESET_SYNC(iRESET_SYNC),
    .iSYSREG_SPR(iSYSREG_SPR),
    .iSYSREG_TISR(iSYSREG_TISR),
    .iSYSREG_TIDR(iSYSREG_TIDR),
    .iRD_START(b_state == PL_STT_IDLE && iRETURN_START && spr_exchange_condition),
    .iRD_KERNEL(1'b0),                  
    .oFINISH(spr_exchange_finish),
    .oFINISH_SPR(spr_exchange_spr),
    .oLDST_USE(oLDST_USE),
    .oLDST_REQ(oLDST_REQ),
    .iLDST_BUSY(iLDST_BUSY),
    .oLDST_ORDER(oLDST_ORDER),          
    .oLDST_RW(oLDST_RW),                
    .oLDST_ASID(oLDST_ASID),
    .oLDST_MMUMOD(oLDST_MMUMOD),
    .oLDST_PDT(oLDST_PDT),
    .oLDST_ADDR(oLDST_ADDR),
    .oLDST_DATA(oLDST_DATA),
    .iLDST_REQ(iLDST_REQ),
    .iLDST_DATA(iLDST_DATA)
);
reg [31:0] b_spr;
always@(posedge iCLOCK or negedge inRESET)begin
    if(!inRESET)begin                   
        b_spr <= 32'h0;                 
    end
    else if(iRESET_SYNC)begin           
        b_spr <= 32'h0;                 
    end
    else begin                          
        if(b_state == PL_STT_SPR_EXCHANGE && spr_exchange_finish)begin 
            b_spr <= spr_exchange_spr;  
        end
        else if(b_state == PL_STT_IDLE && iRETURN_START)begin 
            b_spr <= iSYSREG_SPR;       
        end
    end
end
assign oFINISH = b_finish;              
assign oFINISH_SPR_VALID = (b_state_delay == PL_STT_SPR_EXCHANGE); 
assign oFINISH_SPR = (b_state_delay == PL_STT_SPR_EXCHANGE)? b_spr : iSYSREG_SPR; 
endmodule 