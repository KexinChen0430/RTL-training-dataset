
module oh_datagate  #(parameter  DW = 32, PS = 3)
  (input  clk,
   input  en,
   input  [DW-1:0] din,
   output [DW-1:0] dout);

  reg  [(-1)+PS:0] enable_pipe;
  wire enable;

  
  always @(posedge clk)
      enable_pipe[(-1)+PS:0] <= {enable_pipe[PS+(-1<<1):0],en};
  assign enable = {enable_pipe[(-1)+PS:0],en};
  assign dout[DW-1:0] = {DW{enable}} & din[DW-1:0];
endmodule

