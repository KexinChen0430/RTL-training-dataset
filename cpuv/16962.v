module fifo_generator_rx_inst(clk, rst, din, wr_en, rd_en, dout, full, empty)
;
  input clk;        
  input rst;        
  input [63:0]din;  
  input wr_en;      
  input rd_en;      
  output [63:0]dout; 
  output full;      
  output empty;     
endmodule