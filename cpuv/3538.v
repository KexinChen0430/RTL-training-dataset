module riscv_divider
(
     input           clk_i  
    ,input           rst_i  
    ,input           opcode_valid_i  
    ,input  [ 31:0]  opcode_opcode_i  
    ,input  [ 31:0]  opcode_pc_i  
    ,input           opcode_invalid_i  
    ,input  [  4:0]  opcode_rd_idx_i  
    ,input  [  4:0]  opcode_ra_idx_i  
    ,input  [  4:0]  opcode_rb_idx_i  
    ,input  [ 31:0]  opcode_ra_operand_i  
    ,input  [ 31:0]  opcode_rb_operand_i  
    ,output          writeback_valid_o  
    ,output [ 31:0]  writeback_value_o  
);