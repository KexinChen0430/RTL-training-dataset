
module id_ex_reg  #(parameter 
       INSTRUCTION_WIDTH = 32,
       PC_WIDTH          = 20,
       DATA_WIDTH        = 32,
       OPCODE_WIDTH      = 6,
       FUNCTION_WIDTH    = 5,
       REG_ADDR_WIDTH    = 5,
       IMEDIATE_WIDTH    = 16,
       PC_OFFSET_WIDTH   = 26)
  (input  clk,
   input  rst_n,
   input  en,
   input  flush_in,
   input  [DATA_WIDTH-1:0] data_alu_a_in,
   input  [DATA_WIDTH-1:0] data_alu_b_in,
   input  [PC_WIDTH-1:0] new_pc_in,
   input  [INSTRUCTION_WIDTH+(-1):0] instruction_in,
   input  [OPCODE_WIDTH-1:0] opcode_in,
   input  [FUNCTION_WIDTH+(-1):0] inst_function_in,
   input  [REG_ADDR_WIDTH+(-1):0] reg_rd_addr1_in,
   input  [REG_ADDR_WIDTH+(-1):0] reg_rd_addr2_in,
   input  [REG_ADDR_WIDTH+(-1):0] reg_a_wr_addr_in,
   input  [REG_ADDR_WIDTH+(-1):0] reg_b_wr_addr_in,
   input  reg_a_wr_en_in,
   input  reg_b_wr_en_in,
   input  [DATA_WIDTH-1:0] constant_in,
   input  imm_inst_in,
   input  [PC_OFFSET_WIDTH+(-1):0] pc_offset_in,
   input  mem_data_rd_en_in,
   input  mem_data_wr_en_in,
   input  write_back_mux_sel_in,
   input  branch_inst_in,
   input  branch_use_r_in,
   input  jump_inst_in,
   input  jump_use_r_in,
   output reg [DATA_WIDTH-1:0] data_alu_a_out,
   output reg [DATA_WIDTH-1:0] data_alu_b_out,
   output reg [PC_WIDTH-1:0] new_pc_out,
   output reg [INSTRUCTION_WIDTH+(-1):0] instruction_out,
   output reg [OPCODE_WIDTH-1:0] opcode_out,
   output reg [FUNCTION_WIDTH+(-1):0] inst_function_out,
   output reg [REG_ADDR_WIDTH+(-1):0] reg_rd_addr1_out,
   output reg [REG_ADDR_WIDTH+(-1):0] reg_rd_addr2_out,
   output reg [REG_ADDR_WIDTH+(-1):0] reg_a_wr_addr_out,
   output reg [REG_ADDR_WIDTH+(-1):0] reg_b_wr_addr_out,
   output reg reg_a_wr_en_out,
   output reg reg_b_wr_en_out,
   output reg [DATA_WIDTH-1:0] constant_out,
   output reg imm_inst_out,
   output reg [PC_OFFSET_WIDTH+(-1):0] pc_offset_out,
   output reg mem_data_rd_en_out,
   output reg mem_data_wr_en_out,
   output reg write_back_mux_sel_out,
   output reg branch_inst_out,
   output reg branch_use_r_out,
   output reg jump_inst_out,
   output reg jump_use_r_out);

  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin

          end
        else if (en) 
          begin
            if (flush_in) 
              begin

              end
            else 
              begin

              end
          end
          
      end
endmodule

