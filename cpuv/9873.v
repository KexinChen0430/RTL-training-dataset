module trv_br_cond
(
  input wire [2:0] op,
  input wire [31:0] rs1,
  input wire [31:0] rs2,
  output wire take_branch
);
  wire signed s_rs1, s_rs2;
  s_rs1 = rs1;
  s_rs2 = rs2;
  always @* begin
    take_branch = 0;
    case (op)
      `TRV_OPCODE_BR_EQ:
        take_branch = rs1 == rs2;
      `TRV_OPCODE_BR_NE:
        take_branch = rs1 != rs2;
      `TRV_OPCODE_BR_LT:
        take_branch = s_rs1 < s_rs2;
      `TRV_OPCODE_BR_GE:
        take_branch = !(s_rs1 < s_rs2);
      `TRV_OPCODE_BR_LTU:
        take_branch = rs1 < rs2;
      `TRV_OPCODE_BR_GEU:
        take_branch = !(rs1 < rs2);
    endcase
  end
endmodule