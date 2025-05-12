
module branch_control  #(parameter 
       DATA_WIDTH      = 32,
       PC_WIDTH        = 6,
       PC_OFFSET_WIDTH = 25)
  (input  jmp_inst_in,
   input  jmp_use_r_in,
   input  branch_use_r_in,
   input  branch_inst_in,
   input  branch_result_in,
   input  [PC_WIDTH+(0-1):0] pc_in,
   input  [DATA_WIDTH-1:0] reg_a_data_in,
   input  [DATA_WIDTH-1:0] reg_b_data_in,
   input  [PC_OFFSET_WIDTH-1:0] pc_offset_in,
   output select_new_pc_out,
   output [PC_WIDTH+(0-1):0] pc_out);

  wire [DATA_WIDTH-1:0] jmp_val;
  wire [DATA_WIDTH-1:0] branch_val;
  wire [PC_WIDTH+(0-1):0] pc_jump;

  assign pc_jump = {pc_offset_in,{1+1{1'b0}}};
  assign select_new_pc_out = (jmp_inst_in | branch_inst_in) & (branch_result_in | jmp_inst_in);
  assign branch_val = branch_use_r_in ? reg_a_data_in : (({reg_b_data_in,{1+1{1'b0}}}+4)+pc_in);
  assign jmp_val = jmp_use_r_in ? reg_a_data_in : pc_jump;
  assign pc_out = jmp_inst_in ? jmp_val : branch_val;
endmodule

