module YL3_Shift_Register(
  input        CLK,        
  input [15:0] DATA_IN,    
  input        EN_IN,      
  output       RDY,        
  output       RCLK,       
  output       SRCLK,      
  output       SER_OUT     
);