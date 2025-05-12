module IDELAYE2_VPR (
  input C, 
  input CE, 
  input CINVCTRL, 
  input CNTVALUEIN0, 
  input CNTVALUEIN1, 
  input CNTVALUEIN2, 
  input CNTVALUEIN3, 
  input CNTVALUEIN4, 
  input DATAIN, 
  input IDATAIN, 
  input INC, 
  input LD, 
  input LDPIPEEN, 
  input REGRST, 
  output CNTVALUEOUT0, 
  output CNTVALUEOUT1, 
  output CNTVALUEOUT2, 
  output CNTVALUEOUT3, 
  output CNTVALUEOUT4, 
  output DATAOUT 
  );
  parameter [0:0] IN_USE = 1'b0; 
  parameter [4:0] IDELAY_VALUE = 5'b00000; 
  parameter [4:0] ZIDELAY_VALUE = 5'b11111; 
  parameter [0:0] PIPE_SEL = 1'b0; 
  parameter [0:0] CINVCTRL_SEL = 1'b0; 
  parameter [0:0] DELAY_SRC_DATAIN = 1'b0; 
  parameter [0:0] DELAY_SRC_IDATAIN = 1'b0; 
  parameter [0:0] HIGH_PERFORMANCE_MODE = 1'b0; 
  parameter [0:0] DELAY_TYPE_FIXED = 1'b0; 
  parameter [0:0] DELAY_TYPE_VAR_LOAD = 1'b0; 
  parameter [0:0] DELAY_TYPE_VARIABLE = 1'b0; 
  parameter [0:0] IS_DATAIN_INVERTED = 1'b0; 
  parameter [0:0] IS_IDATAIN_INVERTED = 1'b0; 
endmodule