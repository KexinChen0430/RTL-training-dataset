module async_fifo_align_64in_out(clk, rst, din, wr_en, rd_en, dout, full, empty, valid)
;
  input clk;        
  input rst;        
  input [63:0]din;  
  input wr_en;      
  input rd_en;      
  output [63:0]dout; 
  output full;      
  output empty;     
  output valid;     
endmodule