module or1200_freeze(
	clk, rst,
	multicycle, flushpipe, extend_flush, lsu_stall, if_stall,
	lsu_unstall, du_stall, mac_stall,
	force_dslot_fetch, abort_ex,
	genpc_freeze, if_freeze, id_freeze, ex_freeze, wb_freeze,
	icpu_ack_i, icpu_err_i
); 
input				clk; 
input				rst; 
input	[`OR1200_MULTICYCLE_WIDTH-1:0]	multicycle; 
input				flushpipe; 
input				extend_flush; 
input				lsu_stall; 
input				if_stall; 
input				lsu_unstall; 
input				force_dslot_fetch; 
input				abort_ex; 
input				du_stall; 
input				mac_stall; 
output				genpc_freeze; 
output				if_freeze; 
output				id_freeze; 
output				ex_freeze; 
output				wb_freeze; 
input				icpu_ack_i; 
input				icpu_err_i; 
wire				multicycle_freeze; 
reg	[`OR1200_MULTICYCLE_WIDTH-1:0]	multicycle_cnt; 
reg				flushpipe_r; 
assign genpc_freeze = du_stall | flushpipe_r; 
assign if_freeze = id_freeze | extend_flush; 
assign id_freeze = (lsu_stall | (~lsu_unstall & if_stall) | multicycle_freeze | force_dslot_fetch) | du_stall | mac_stall; 
assign ex_freeze = wb_freeze; 
assign wb_freeze = (lsu_stall | (~lsu_unstall & if_stall) | multicycle_freeze) | du_stall | mac_stall | abort_ex; 
always @(posedge clk or posedge rst) 
	if (rst)
		flushpipe_r <= #1 1'b0; 
	else if (icpu_ack_i | icpu_err_i)
		flushpipe_r <= #1 flushpipe; 
	else if (!flushpipe)
		flushpipe_r <= #1 1'b0; 
assign multicycle_freeze = |multicycle_cnt; 
always @(posedge clk or posedge rst) 
	if (rst)
		multicycle_cnt <= #1 2'b00; 
	else if (|multicycle_cnt)
		multicycle_cnt <= #1 multicycle_cnt - 2'd1; 
	else if (|multicycle & !ex_freeze)
		multicycle_cnt <= #1 multicycle; 
endmodule 