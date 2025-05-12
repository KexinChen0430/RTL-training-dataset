module FetchDecodeStage #(
  parameter ADDR_LEN = `CPU_ADDR_BITS
)(
  input wire clk,
  input wire reset,
  output wire [ADDR_LEN-1:0] s1_imem_addr,
  output wire [ADDR_LEN-1:0] s1_pc,
  input wire [ADDR_LEN-1:0] s3_pc,
  input wire [ADDR_LEN-1:0] override_pc,
  input wire [1:0] s1_pc_sel,
  input wire [`CPU_INST_BITS-1:0] s1_inst,
  output wire [4:0] s1_rs1,
  output wire [4:0] s1_rs2,
  output wire [4:0] s1_rd,
  output wire [11:0] s1_imm_i,
  output wire [19:0] s1_imm_uj,
  output wire [11:0] s1_imm_bs,
  output wire [6:0] s1_opcode,
  output wire [2:0] s1_func,
  output wire s1_add_rshift_type
);
  reg [ADDR_LEN-1:0] pc;
  reg [ADDR_LEN-1:0] next_pc;
  always @(*) begin
    case (s1_pc_sel)
      `S1_PC_SEL_OVERRIDE: next_pc = override_pc;
      `S1_PC_SEL_S3: next_pc = s3_pc;
      `S1_PC_SEL_STALL: next_pc = pc;
      default: next_pc = pc + 4;
    endcase
  end
  assign s1_imem_addr = next_pc;
  always @(posedge clk) begin
    if (reset) pc <= 0;
    else pc <= next_pc;
  end
  assign s1_rs1 = s1_inst[19:15];
  assign s1_rs2 = s1_inst[24:20];
  assign s1_rd = s1_inst[11:7];
  assign s1_imm_i = s1_inst[31:20];
  assign s1_imm_uj = s1_inst[31:12];
  assign s1_imm_bs = {s1_inst[31:25], s1_inst[11:7]};
  assign s1_opcode = s1_inst[6:0];
  assign s1_func = s1_inst[14:12];
  assign s1_add_rshift_type = s1_inst[30];
  assign s1_pc = pc;
endmodule