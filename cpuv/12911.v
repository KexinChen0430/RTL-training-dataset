module shd_fifo(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, empty) 
; 
  input rst; 
  input wr_clk; 
  input rd_clk; 
  input [127:0]din; 
  input wr_en; 
  input rd_en; 
  output [127:0]dout; 
  output full; 
  output empty; 
endmodule 