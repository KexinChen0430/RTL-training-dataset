module blk_mem_gen_1(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb) 
; 
  input clka; 
  input ena; 
  input [0:0]wea; 
  input [17:0]addra; 
  input [15:0]dina; 
  input clkb; 
  input enb; 
  input [17:0]addrb; 
  output [15:0]doutb; 
endmodule 