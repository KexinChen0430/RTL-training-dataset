
module oh_datagate  #(parameter  DW = 32, PS = 3)
  (input  clk,
   input  en,
   input  [DW+(0-1):0] din,
   output [DW+(0-1):0] dout);

  reg  [(0-1)+PS:0] enable_pipe;
  wire enable;

  
  always @(posedge clk)
      enable_pipe[(0-1)+PS:0] <= {enable_pipe[PS-(1+1):0],en};
  assign enable = {enable_pipe[(0-1)+PS:0],en};
  assign dout[DW+(0-1):0] = {DW{enable}} & din[DW+(0-1):0];
endmodule

