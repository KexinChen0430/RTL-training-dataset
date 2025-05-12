module output_fifo(clk, srst, din, wr_en, rd_en, dout, full, empty)
;
  input clk;        
  input srst;       
  input [11:0]din;  
  input wr_en;      
  input rd_en;      
  output [11:0]dout; 
  output full;      
  output empty;     
endmodule