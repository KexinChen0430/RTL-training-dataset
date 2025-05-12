module ODDR_VPR ( 
  input  CK,      
  input  CE,      
  input  SR,      
  input  D1,      
  input  D2,      
  output Q        
);
  parameter [0:0] ZINV_CLK = 1'b1; 
  parameter [0:0] ZINV_D1  = 1'b1; 
  parameter [0:0] ZINV_D2  = 1'b1; 
  parameter [0:0] INV_D1  = 1'b0;  
  parameter [0:0] INV_D2  = 1'b0;  
  parameter [0:0] SRTYPE_SYNC = 1'b0; 
  parameter [0:0] SAME_EDGE   = 1'b1; 
  parameter [0:0] ZINIT_Q  = 1'b1;    
  parameter [0:0] ZSRVAL_Q = 1'b1;    
endmodule 