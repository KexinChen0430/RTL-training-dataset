module or1200_freeze
(
   clk, rst,
   multicycle, wait_on, flushpipe, extend_flush, lsu_stall, if_stall,
   lsu_unstall, du_stall, mac_stall,
   force_dslot_fetch, abort_ex,
   genpc_freeze, if_freeze, id_freeze, ex_freeze, wb_freeze, saving_if_insn,
   fpu_done, mtspr_done,
   icpu_ack_i, icpu_err_i
);
input clk; 
input rst; 
input [`OR1200_MULTICYCLE_WIDTH-1:0] multicycle; 
input [`OR1200_WAIT_ON_WIDTH-1:0] wait_on; 
input flushpipe; 
input extend_flush; 
input lsu_stall; 
input if_stall; 
input lsu_unstall; 
input force_dslot_fetch; 
input abort_ex; 
input du_stall; 
input mac_stall; 
output genpc_freeze; 
output if_freeze; 
output id_freeze; 
output ex_freeze; 
output wb_freeze; 
input saving_if_insn; 
input fpu_done; 
input mtspr_done; 
input icpu_ack_i; 
input icpu_err_i; 
wire multicycle_freeze; 
reg [`OR1200_MULTICYCLE_WIDTH-1:0] multicycle_cnt; 
reg flushpipe_r; 
reg [`OR1200_WAIT_ON_WIDTH-1:0] waiting_on; 
assign genpc_freeze = (du_stall & !saving_if_insn) | flushpipe_r;
assign if_freeze = id_freeze | extend_flush;
assign id_freeze = (lsu_stall | (~lsu_unstall & if_stall) | multicycle_freeze
                    | (|waiting_on) | force_dslot_fetch) | du_stall;
assign ex_freeze = wb_freeze;
assign wb_freeze = (lsu_stall | (~lsu_unstall & if_stall) | multicycle_freeze
                    | (|waiting_on)) | du_stall | abort_ex;
always @(posedge clk or `OR1200_RST_EVENT rst)
    if (rst == `OR1200_RST_VALUE)
        flushpipe_r <= 1'b0;
    else if (icpu_ack_i | icpu_err_i)
        flushpipe_r <= flushpipe;
    else if (!flushpipe)
        flushpipe_r <= 1'b0;
assign multicycle_freeze = |multicycle_cnt;
always @(posedge clk or `OR1200_RST_EVENT rst)
    if (rst == `OR1200_RST_VALUE)
        multicycle_cnt <= `OR1200_MULTICYCLE_WIDTH'd0;
    else if (|multicycle_cnt)
        multicycle_cnt <= multicycle_cnt - `OR1200_MULTICYCLE_WIDTH'd1;
    else if (|multicycle & !ex_freeze)
        multicycle_cnt <= multicycle;
always @(posedge clk or `OR1200_RST_EVENT rst)
    if (rst == `OR1200_RST_VALUE)
        waiting_on <= 0;
    else if ((waiting_on == `OR1200_WAIT_ON_MULTMAC) & !mac_stall)
        waiting_on <= 0;
    else if ((waiting_on == `OR1200_WAIT_ON_FPU) & fpu_done)
        waiting_on <= 0;
    else if ((waiting_on == `OR1200_WAIT_ON_MTSPR) & mtspr_done)
        waiting_on <= 0;
    else if (!ex_freeze)
        waiting_on <= wait_on;
endmodule