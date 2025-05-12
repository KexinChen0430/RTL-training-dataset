module fifo_generator_0(clk, srst, din, wr_en, rd_en, dout, full, empty) 
; 
  input clk; 
  input srst; 
  input [63:0]din; 
  input wr_en; 
  input rd_en; 
  output [63:0]dout; 
  output full; 
  output empty; 
endmodule 