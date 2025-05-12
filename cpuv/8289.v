module IDDR_VPR ( 
  input  CK,      
  input  CKB,     
  input  CE,      
  input  SR,      
  input  D,       
  output Q1,      
  output Q2       
);
  parameter [0:0] ZINV_D = 1'b1; 
  parameter [0:0] ZINV_C = 1'b1; 
  parameter [0:0] SRTYPE_SYNC = 1'b0; 
  parameter [0:0] SAME_EDGE     = 1'b0; 
  parameter [0:0] OPPOSITE_EDGE = 1'b0; 
  parameter [0:0] ZINIT_Q1   = 1'b0; 
  parameter [0:0] ZINIT_Q2   = 1'b0; 
  parameter [0:0] ZINIT_Q3   = 1'b0; 
  parameter [0:0] ZINIT_Q4   = 1'b0; 
  parameter [0:0] ZSRVAL_Q12 = 1'b0; 
  parameter [0:0] ZSRVAL_Q34 = 1'b0; 
endmodule 