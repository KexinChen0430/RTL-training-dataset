
module oh_datagate  #(parameter  DW = 32, PS = 3)
  (input  clk,
   input  en,
   input  [(0-1)+DW:0] din,
   output [(0-1)+DW:0] dout);

  reg  [PS+(0-1):0] enable_pipe;
  wire enable;

  
  always @(posedge clk)
      enable_pipe[PS+(0-1):0] <= {enable_pipe[(-2)+PS:0],en};
  assign enable = {enable_pipe[PS+(0-1):0],en};
  assign dout[(0-1)+DW:0] = {DW{enable}} & din[(0-1)+DW:0];
endmodule

