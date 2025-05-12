module fifo_generator_3(wr_clk, wr_rst, rd_clk, rd_rst, din, wr_en, rd_en, dout, full, empty)
;
  input wr_clk;       
  input wr_rst;       
  input rd_clk;       
  input rd_rst;       
  input [9:0]din;     
  input wr_en;        
  input rd_en;        
  output [9:0]dout;   
  output full;        
  output empty;       
endmodule