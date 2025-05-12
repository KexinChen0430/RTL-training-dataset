module ISERDESE2_IDELAY_VPR ( 
  input  BITSLIP, 
  input  CE1, 
  input  CE2, 
  input  CLK, 
  input  CLKB, 
  input  CLKDIV, 
  input  RST, 
  input  DDLY, 
  output Q1, 
  output Q2, 
  output Q3, 
  output Q4, 
  output Q5, 
  output Q6, 
  output Q7, 
  output Q8 
  );
  parameter [0:0] MEMORY_DDR3_4     = 1'b0; 
  parameter [0:0] MEMORY_DDR_4      = 1'b0; 
  parameter [0:0] MEMORY_QDR_4      = 1'b0; 
  parameter [0:0] NETWORKING_SDR_2  = 1'b0; 
  parameter [0:0] NETWORKING_SDR_3  = 1'b0; 
  parameter [0:0] NETWORKING_SDR_4  = 1'b0; 
  parameter [0:0] NETWORKING_SDR_5  = 1'b0; 
  parameter [0:0] NETWORKING_SDR_6  = 1'b0; 
  parameter [0:0] NETWORKING_SDR_7  = 1'b0; 
  parameter [0:0] NETWORKING_SDR_8  = 1'b0; 
  parameter [0:0] NETWORKING_DDR_4  = 1'b0; 
  parameter [0:0] NETWORKING_DDR_6  = 1'b0; 
  parameter [0:0] NETWORKING_DDR_8  = 1'b0; 
  parameter [0:0] NETWORKING_DDR_10 = 1'b0; 
  parameter [0:0] NETWORKING_DDR_14 = 1'b0; 
  parameter [0:0] OVERSAMPLE_DDR_4  = 1'b0; 
  parameter [0:0] NUM_CE_N1 = 1'b0; 
  parameter [0:0] NUM_CE_N2 = 1'b1; 
  parameter [0:0] IOBDELAY_IFD = 1'b0; 
  parameter [0:0] IOBDELAY_IBUF = 1'b0; 
  parameter [0:0] ZINIT_Q1 = 1'b0; 
  parameter [0:0] ZINIT_Q2 = 1'b0; 
  parameter [0:0] ZINIT_Q3 = 1'b0; 
  parameter [0:0] ZINIT_Q4 = 1'b0; 
  parameter [0:0] ZSRVAL_Q1 = 1'b0; 
  parameter [0:0] ZSRVAL_Q2 = 1'b0; 
  parameter [0:0] ZSRVAL_Q3 = 1'b0; 
  parameter [0:0] ZSRVAL_Q4 = 1'b0; 
  parameter [0:0] ZINV_D = 1'b0; 
  parameter [0:0] ZINV_C = 1'b0; 
endmodule 