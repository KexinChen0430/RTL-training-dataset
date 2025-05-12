
module oh_datagate  #(parameter  DW = 32, N = 3)
  (input  clk,
   input  en,
   input  [DW-1:0] din,
   output [DW-1:0] dout);

  reg  [(0-1)+N:0] enable_pipe;
  wire enable;

  
  always @(posedge clk)
      enable_pipe[(0-1)+N:0] <= {enable_pipe[N-1<<<1:0],en};
  assign enable = en | |enable_pipe[(0-1)+N:0];
  assign dout[DW-1:0] = din[DW-1:0] & {DW{enable}};
endmodule

