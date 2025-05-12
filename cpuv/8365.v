module OSERDESE2_VPR ( 
  input CLK, 
  input CLKDIV, 
  input D1, 
  input D2, 
  input D3, 
  input D4, 
  input D5, 
  input D6, 
  input D7, 
  input D8, 
  input OCE, 
  input RST, 
  input T1, 
  input T2, 
  input T3, 
  input T4, 
  input TCE, 
  output OFB, 
  output OQ, 
  output TFB, 
  output TQ 
);
  parameter [0:0] SERDES_MODE_SLAVE = 1'b0; 
  parameter [0:0] TRISTATE_WIDTH_W4 = 1'b0; 
  parameter [0:0] DATA_RATE_OQ_DDR = 1'b0; 
  parameter [0:0] DATA_RATE_OQ_SDR = 1'b0; 
  parameter [0:0] DATA_RATE_TQ_BUF = 1'b0; 
  parameter [0:0] DATA_RATE_TQ_DDR = 1'b0; 
  parameter [0:0] DATA_RATE_TQ_SDR = 1'b0; 
  parameter [0:0] DATA_WIDTH_DDR_W6_8 = 1'b0; 
  parameter [0:0] DATA_WIDTH_SDR_W2_4_5_6 = 1'b0; 
  parameter [0:0] DATA_WIDTH_W2 = 1'b0; 
  parameter [0:0] DATA_WIDTH_W3 = 1'b0; 
  parameter [0:0] DATA_WIDTH_W4 = 1'b0; 
  parameter [0:0] DATA_WIDTH_W5 = 1'b0; 
  parameter [0:0] DATA_WIDTH_W6 = 1'b0; 
  parameter [0:0] DATA_WIDTH_W7 = 1'b0; 
  parameter [0:0] DATA_WIDTH_W8 = 1'b0; 
  parameter [0:0] IS_CLKDIV_INVERTED = 1'b0; 
  parameter [0:0] IS_D1_INVERTED = 1'b0; 
  parameter [0:0] IS_D2_INVERTED = 1'b0; 
  parameter [0:0] IS_D3_INVERTED = 1'b0; 
  parameter [0:0] IS_D4_INVERTED = 1'b0; 
  parameter [0:0] IS_D5_INVERTED = 1'b0; 
  parameter [0:0] IS_D6_INVERTED = 1'b0; 
  parameter [0:0] IS_D7_INVERTED = 1'b0; 
  parameter [0:0] IS_D8_INVERTED = 1'b0; 
  parameter [0:0] ZINV_CLK = 1'b0; 
  parameter [0:0] ZINV_T1 = 1'b0; 
  parameter [0:0] ZINV_T2 = 1'b0; 
  parameter [0:0] ZINV_T3 = 1'b0; 
  parameter [0:0] ZINV_T4 = 1'b0; 
  parameter [0:0] ZINIT_OQ = 1'b0; 
  parameter [0:0] ZINIT_TQ = 1'b0; 
  parameter [0:0] ZSRVAL_OQ = 1'b0; 
  parameter [0:0] ZSRVAL_TQ = 1'b0; 
endmodule 