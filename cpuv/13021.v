module pixelq_op_Block_proc ( 
        ap_clk, 
        ap_rst, 
        ap_start, 
        ap_done, 
        ap_continue, 
        ap_idle, 
        ap_ready, 
        ap_return_0, 
        ap_return_1, 
        ap_return_2, 
        ap_return_3 
);
parameter    ap_const_logic_1 = 1'b1; 
parameter    ap_const_logic_0 = 1'b0; 
parameter    ap_ST_st1_fsm_0 = 1'b1; 
parameter    ap_const_lv32_0 = 32'b00000000000000000000000000000000; 
parameter    ap_const_lv1_1 = 1'b1; 
parameter    ap_const_lv12_438 = 12'b10000111000; 
parameter    ap_const_lv12_780 = 12'b11110000000; 
parameter    ap_true = 1'b1; 
input   ap_clk; 
input   ap_rst; 
input   ap_start; 
output   ap_done; 
input   ap_continue; 
output   ap_idle; 
output   ap_ready; 
output  [11:0] ap_return_0; 
output  [11:0] ap_return_1; 
output  [11:0] ap_return_2; 
output  [11:0] ap_return_3; 
reg ap_done; 
reg ap_idle; 
reg ap_ready; 
reg    ap_done_reg = 1'b0; 
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm = 1'b1; 
reg    ap_sig_cseq_ST_st1_fsm_0; 
reg    ap_sig_bdd_20; 
reg    ap_sig_bdd_82; 
reg   [0:0] ap_NS_fsm; 
always @ (posedge ap_clk)
begin : ap_ret_ap_CS_fsm
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_st1_fsm_0; 
    end else begin
        ap_CS_fsm <= ap_NS_fsm; 
    end
end
always @ (posedge ap_clk)
begin : ap_ret_ap_done_reg
    if (ap_rst == 1'b1) begin
        ap_done_reg <= ap_const_logic_0; 
    end else begin
        if ((ap_const_logic_1 == ap_continue)) begin
            ap_done_reg <= ap_const_logic_0; 
        end else if (((ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0) & ~ap_sig_bdd_82)) begin
            ap_done_reg <= ap_const_logic_1; 
        end
    end
end
always @ (ap_done_reg or ap_sig_cseq_ST_st1_fsm_0 or ap_sig_bdd_82)
begin
    if (((ap_const_logic_1 == ap_done_reg) | ((ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0) & ~ap_sig_bdd_82))) begin
        ap_done = ap_const_logic_1; 
    end else begin
        ap_done = ap_const_logic_0; 
    end
end
always @ (ap_start or ap_sig_cseq_ST_st1_fsm_0)
begin
    if ((~(ap_const_logic_1 == ap_start) & (ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0))) begin
        ap_idle = ap_const_logic_1; 
    end else begin
        ap_idle = ap_const_logic_0; 
    end
end
always @ (ap_sig_cseq_ST_st1_fsm_0 or ap_sig_bdd_82)
begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0) & ~ap_sig_bdd_82)) begin
        ap_ready = ap_const_logic_1; 
    end else begin
        ap_ready = ap_const_logic_0; 
    end
end
always @ (ap_sig_bdd_20)
begin
    if (ap_sig_bdd_20) begin
        ap_sig_cseq_ST_st1_fsm_0 = ap_const_logic_1; 
    end else begin
        ap_sig_cseq_ST_st1_fsm_0 = ap_const_logic_0; 
    end
end
always @ (ap_CS_fsm or ap_sig_bdd_82)
begin
    case (ap_CS_fsm)
        ap_ST_st1_fsm_0 :
        begin
            ap_NS_fsm = ap_ST_st1_fsm_0; 
        end
        default :
        begin
            ap_NS_fsm = 'bx; 
        end
    endcase
end
assign ap_return_0 = ap_const_lv12_438; 
assign ap_return_1 = ap_const_lv12_438; 
assign ap_return_2 = ap_const_lv12_780; 
assign ap_return_3 = ap_const_lv12_780; 
always @ (ap_CS_fsm)
begin
    ap_sig_bdd_20 = (ap_CS_fsm[ap_const_lv32_0] == ap_const_lv1_1); 
end
always @ (ap_start or ap_done_reg)
begin
    ap_sig_bdd_82 = ((ap_start == ap_const_logic_0) | (ap_done_reg == ap_const_logic_1)); 
end
endmodule