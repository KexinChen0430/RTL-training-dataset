module or1200_genpc(
    clk, rst,
    icpu_adr_o, icpu_cycstb_o, icpu_sel_o, icpu_tag_o,
    icpu_rty_i, icpu_adr_i,
    branch_op, except_type, except_prefix,
    branch_addrofs, lr_restor, flag, taken, except_start,
    binsn_addr, epcr, spr_dat_i, spr_pc_we, genpc_refetch,
    genpc_freeze, genpc_stop_prefetch, no_more_dslot
);
input clk;
input rst;
output [31:0] icpu_adr_o;          
output icpu_cycstb_o;              
output [3:0] icpu_sel_o;           
output [3:0] icpu_tag_o;           
input icpu_rty_i;                  
input [31:0] icpu_adr_i;           
input [`OR1200_BRANCHOP_WIDTH-1:0] branch_op;      
input [`OR1200_EXCEPT_WIDTH-1:0] except_type;      
input except_prefix;                               
input [31:2] branch_addrofs;                       
input [31:0] lr_restor;                            
input flag;                                        
output taken;                                      
input except_start;                                
input [31:2] binsn_addr;                           
input [31:0] epcr;                                 
input [31:0] spr_dat_i;                            
input spr_pc_we;                                   
input genpc_refetch;                               
input genpc_freeze;                                
input genpc_stop_prefetch;                         
input no_more_dslot;                               
reg [31:2] pcreg;                  
reg [31:0] pc;                     
reg taken;                         
reg genpc_refetch_r;               
assign icpu_adr_o = !no_more_dslot & !except_start & !spr_pc_we & (icpu_rty_i | genpc_refetch) ? icpu_adr_i : pc;
assign icpu_cycstb_o = !genpc_freeze;
assign icpu_sel_o = 4'b1111;
assign icpu_tag_o = `OR1200_ITAG_NI;
always @(posedge clk or posedge rst)
    if (rst)
        genpc_refetch_r <= #1 1'b0;
    else if (genpc_refetch)
        genpc_refetch_r <= #1 1'b1;
    else
        genpc_refetch_r <= #1 1'b0;
always @(pcreg or branch_addrofs or binsn_addr or flag or branch_op or except_type
    or except_start or lr_restor or epcr or spr_pc_we or spr_dat_i or except_prefix ) begin
    casex ({spr_pc_we, except_start, branch_op})    
    endcase
end
always @(posedge clk)
    if (rst)
        pcreg <= #1 ({(except_prefix ? `OR1200_EXCEPT_EPH1_P : `OR1200_EXCEPT_EPH0_P), `OR1200_EXCEPT_RESET, `OR1200_EXCEPT_V} - 1) >> 2;
    else if (spr_pc_we)
        pcreg <= #1 spr_dat_i[31:2];
    else if (no_more_dslot | except_start | !genpc_freeze & !icpu_rty_i & !genpc_refetch)
        pcreg <= #1 pc[31:2];
endmodule