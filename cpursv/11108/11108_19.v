
module hazard_unit(input  wire [4:0] rs1_ex_mem_hz_i,
                   input  wire [4:0] rs2_ex_mem_hz_i,
                   input  wire [4:0] rd_mem_wb_hz_i,
                   input  wire [4:0] rd_wb_ret_hz_i,
                   input  wire [1:0] op2sel_ex_mem_hz_i,
                   input  wire rf_en_mem_wb_hz_i,
                   input  wire rf_en_wb_ret_hz_i,
                   input  wire branch_taken_ex_mem_hz_i,
                   input  wire jump_iss_ex_hz_i,
                   input  wire brn_pred_ex_mem_hz_i,
                   output wire stall_fetch_hz_o,
                   output wire stall_iss_hz_o,
                   output wire flush_ex_hz_o,
                   output wire flush_iss_hz_o,
                   output wire [1:0] fwd_p1_ex_mem_hz_o,
                   output wire [1:0] fwd_p2_ex_mem_hz_o);

  wire stall_fetch_hz;
  wire stall_iss_hz;
  wire flush_ex_hz;
  wire flush_iss_hz;
  wire [1:0] fwd_p1_ex_mem_hz;
  wire [1:0] fwd_p2_ex_mem_hz;

  assign stall_fetch_hz_o = stall_fetch_hz;
  assign stall_iss_hz_o = stall_iss_hz;
  assign flush_ex_hz_o = flush_ex_hz;
  assign flush_iss_hz_o = flush_iss_hz;
  assign fwd_p1_ex_mem_hz_o = fwd_p1_ex_mem_hz;
  assign fwd_p2_ex_mem_hz_o = fwd_p2_ex_mem_hz;
  assign fwd_p1_ex_mem_hz = (|(rd_mem_wb_hz_i & (rd_mem_wb_hz_i == rs1_ex_mem_hz_i)) & rf_en_mem_wb_hz_i) ? 2'b10 : 
                            (rf_en_wb_ret_hz_i & |(rd_wb_ret_hz_i & (rd_wb_ret_hz_i == rs1_ex_mem_hz_i))) ? 2'b01 : 2'b00;
  assign fwd_p2_ex_mem_hz = (|(rd_mem_wb_hz_i & (rd_mem_wb_hz_i == rs2_ex_mem_hz_i)) & rf_en_mem_wb_hz_i) ? 2'b10 : 
                            (rf_en_wb_ret_hz_i & |(rd_wb_ret_hz_i & (rd_wb_ret_hz_i == rs2_ex_mem_hz_i))) ? 2'b01 : 2'b00;
  assign stall_fetch_hz = 1'b0;
  assign stall_iss_hz = 1'b0;
  assign flush_ex_hz = branch_taken_ex_mem_hz_i & ~brn_pred_ex_mem_hz_i;
  assign flush_iss_hz = jump_iss_ex_hz_i | ((branch_taken_ex_mem_hz_i | jump_iss_ex_hz_i) & ~brn_pred_ex_mem_hz_i);
endmodule

