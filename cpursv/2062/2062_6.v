
module oh_datagate  #(parameter  DW = 32, N = 3)
  (input  clk,
   input  en,
   input  [DW+(0-1):0] din,
   output [DW+(0-1):0] dout);

  reg  [(0-1)+N:0] enable_pipe;
  wire enable;

  
  always @(posedge clk)
      enable_pipe[(0-1)+N:0] <= {enable_pipe[(0-1<<1)+N:0],en};
  assign enable = |enable_pipe[(0-1)+N:0] | en;
  assign dout[DW+(0-1):0] = {DW{enable}} & din[DW+(0-1):0];
endmodule

