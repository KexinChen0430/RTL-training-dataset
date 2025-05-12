
module oh_datagate  #(parameter  DW = 32, N = 3)
  (input  clk,
   input  en,
   input  [(-1)+DW:0] din,
   output [(-1)+DW:0] dout);

  reg  [N-1:0] enable_pipe;
  wire enable;

  
  always @(posedge clk)
      enable_pipe[N-1:0] <= {enable_pipe[N-1<<1:0],en};
  assign enable = en | |enable_pipe[N-1:0];
  assign dout[(-1)+DW:0] = {DW{enable}} & din[(-1)+DW:0];
endmodule

