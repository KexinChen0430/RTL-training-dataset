module fifo_generator_2(clk, rst, din, wr_en, rd_en, dout, full, empty)
;
  input clk; 
  input rst; 
  input [88:0]din; 
  input wr_en; 
  input rd_en; 
  output [88:0]dout; 
  output full; 
  output empty; 
endmodule 