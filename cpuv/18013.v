module IDELAYE2 (...); 
    parameter CINVCTRL_SEL = "FALSE"; 
    parameter DELAY_SRC = "IDATAIN"; 
    parameter HIGH_PERFORMANCE_MODE = "FALSE"; 
    parameter IDELAY_TYPE = "FIXED"; 
    parameter integer IDELAY_VALUE = 0; 
    parameter [0:0] IS_C_INVERTED = 1'b0; 
    parameter [0:0] IS_DATAIN_INVERTED = 1'b0; 
    parameter [0:0] IS_IDATAIN_INVERTED = 1'b0; 
    parameter PIPE_SEL = "FALSE"; 
    parameter real REFCLK_FREQUENCY = 200.0; 
    parameter SIGNAL_PATTERN = "DATA"; 
    parameter integer SIM_DELAY_D = 0; 
    output [4:0] CNTVALUEOUT; 
    output DATAOUT; 
    input C; 
    input CE; 
    input CINVCTRL; 
    input [4:0] CNTVALUEIN; 
    input DATAIN; 
    input IDATAIN; 
    input INC; 
    input LD; 
    input LDPIPEEN; 
    input REGRST; 
endmodule 