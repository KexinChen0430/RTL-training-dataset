
module oh_datagate  #(parameter  DW = 32, N = 3)
  (input  clk,
   input  en,
   input  [DW+(0-1):0] din,
   output [DW+(0-1):0] dout);

  reg  [N+(0-1):0] enable_pipe;
  wire enable;

  
  always @(posedge clk)
      enable_pipe[N+(0-1):0] <= {enable_pipe[N+(-(1+1)):0],en};
  assign enable = en | |enable_pipe[N+(0-1):0];
  assign dout[DW+(0-1):0] = din[DW+(0-1):0] & {DW{enable}};
endmodule

