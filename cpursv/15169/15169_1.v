
module RAT_ControlUnit_0_0(CLK,C,Z,INT,RST,OPCODE_HI_5,OPCODE_LO_2,PC_LD,PC_INC,
                           PC_RESET,PC_MUX_SEL,SP_LD,SP_RESET,SP_INCR,SP_DECR,RF_WR,
                           RF_WR_SEL,ALU_SEL,ALU_OPY_SEL,SCR_WR,SCR_ADDR_SEL,
                           SCR_DATA_SEL,C_FLAG_SEL,C_FLAG_LD,C_FLAG_SET,C_FLAG_CLR,
                           SHAD_C_LD,Z_FLAG_SEL,Z_FLAG_LD,Z_FLAG_SET,Z_FLAG_CLR,
                           SHAD_Z_LD,I_FLAG_SET,I_FLAG_CLR,IO_OE);

  input  CLK;
  input  C;
  input  Z;
  input  INT;
  input  RST;
  input  [4:0] OPCODE_HI_5;
  input  [1:0] OPCODE_LO_2;
  output PC_LD;
  output PC_INC;
  output PC_RESET;
  output [1:0] PC_MUX_SEL;
  output SP_LD;
  output SP_RESET;
  output SP_INCR;
  output SP_DECR;
  output RF_WR;
  output [1:0] RF_WR_SEL;
  output [3:0] ALU_SEL;
  output ALU_OPY_SEL;
  output SCR_WR;
  output [1:0] SCR_ADDR_SEL;
  output SCR_DATA_SEL;
  output C_FLAG_SEL;
  output C_FLAG_LD;
  output C_FLAG_SET;
  output C_FLAG_CLR;
  output SHAD_C_LD;
  output Z_FLAG_SEL;
  output Z_FLAG_LD;
  output Z_FLAG_SET;
  output Z_FLAG_CLR;
  output SHAD_Z_LD;
  output I_FLAG_SET;
  output I_FLAG_CLR;
  output IO_OE;


endmodule

