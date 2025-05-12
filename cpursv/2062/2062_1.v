
module oh_datagate  #(parameter  DW = 32, N = 3)
  (input  clk,
   input  en,
   input  [DW-1:0] din,
   output [DW-1:0] dout);

  reg  [N-1:0] enable_pipe;
  wire enable;

  
  always @(posedge clk)
      enable_pipe[N-1:0] <= {enable_pipe[(-1<<<1)+N:0],en};
  assign enable = |enable_pipe[N-1:0] | en;
  assign dout[DW-1:0] = {DW{enable}} & din[DW-1:0];
endmodule

