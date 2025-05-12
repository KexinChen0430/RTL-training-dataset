module EG_LOGIC_BUFIO( 
  input clki, 
  input rst, 
  input coe, 
  output clko, 
  output clkdiv1, 
  output clkdivx 
);
  parameter GSR = "DISABLE"; 
  parameter DIV = 2; 
  parameter STOPCLK = "DISABLE"; 
endmodule 