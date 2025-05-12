module sig1dualRAM(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
;
  input clka; 
  input ena;  
  input [0:0]wea; 
  input [13:0]addra; 
  input [7:0]dina; 
  input clkb; 
  input enb;  
  input [13:0]addrb; 
  output [7:0]doutb; 
endmodule 