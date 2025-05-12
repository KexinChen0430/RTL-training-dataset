module bram_1024_3(clka, ena, wea, addra, dina, douta)
;
  input clka; 
  input ena;  
  input [0:0]wea; 
  input [9:0]addra; 
  input [19:0]dina; 
  output [19:0]douta; 
endmodule