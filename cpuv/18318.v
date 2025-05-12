module scfifo_32in_32out_1kb(clk, rst, din, wr_en, rd_en, dout, full, empty)
;
  input clk;          
  input rst;          
  input [31:0]din;    
  input wr_en;        
  input rd_en;        
  output [31:0]dout;  
  output full;        
  output empty;       
endmodule