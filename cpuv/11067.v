module fifo_64in_out(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, empty, valid, rd_data_count)
;
  input rst; 
  input wr_clk; 
  input rd_clk; 
  input [63:0]din; 
  input wr_en; 
  input rd_en; 
  output [63:0]dout; 
  output full; 
  output empty; 
  output valid; 
  output [11:0]rd_data_count; 
endmodule