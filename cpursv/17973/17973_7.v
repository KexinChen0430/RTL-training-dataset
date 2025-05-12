
module wb_dma_inc30r(clk,in,out);

  input  clk;
  input  [29:0] in;
  output [29:0] out;
  parameter  INC30_CENTER = 16;
  reg  [INC30_CENTER:0] out_r;

  
  always @(posedge clk)
      out_r <= #1 1+in[(0-1)+INC30_CENTER:0];
  assign out[29:INC30_CENTER] = in[29:INC30_CENTER]+out_r[INC30_CENTER];
  assign out[(0-1)+INC30_CENTER:0] = out_r;
endmodule

