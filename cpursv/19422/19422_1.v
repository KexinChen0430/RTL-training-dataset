
module IDELAYE2_FINEDELAY(CNTVALUEOUT,DATAOUT,C,CE,CINVCTRL,CNTVALUEIN,DATAIN,IDATAIN,
                          IFDLY,INC,LD,LDPIPEEN,REGRST);

  parameter  CINVCTRL_SEL = FALSE;
  parameter  DELAY_SRC = IDATAIN;
  parameter  FINEDELAY = BYPASS;
  parameter  HIGH_PERFORMANCE_MODE = FALSE;
  parameter  IDELAY_TYPE = FIXED;
  parameter integer  IDELAY_VALUE = 0;
  parameter  IS_C_INVERTED = 1'b0;
  parameter  IS_DATAIN_INVERTED = 1'b0;
  parameter  IS_IDATAIN_INVERTED = 1'b0;
  parameter  PIPE_SEL = FALSE;
  parameter real  REFCLK_FREQUENCY = 200.;
  parameter  SIGNAL_PATTERN = DATA;
  integer  DELAY_D = 0;
  output [4:0] CNTVALUEOUT;
  output DATAOUT;
  input  C;
  input  CE;
  input  CINVCTRL;
  input  [4:0] CNTVALUEIN;
  input  DATAIN;
  input  IDATAIN;
  input  [2:0] IFDLY;
  input  INC;
  input  LD;
  input  LDPIPEEN;
  input  REGRST;


endmodule

