module EG_LOGIC_IDDRx2( 
  output q3, 
  output q2, 
  output q1, 
  output q0, 
  input pclk, 
  input sclk, 
  input d, 
  input rst 
);
  parameter ASYNCRST = "ENABLE"; 
endmodule 