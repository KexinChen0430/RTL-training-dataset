
module oh_delay  #(parameter  DW = 1, N = 1)
  (input  [DW-1:0] in,
   input  clk,
   output [DW-1:0] out);

  reg  [DW-1:0] sync_pipe[N+(0-1):0];

  genvar i;
  
  generate
      
      always @(posedge clk)
          sync_pipe[0] <= in[DW-1:0];
      for (i = 1; i < N; i = 1+i)
          begin : gen_pipe
            
            always @(posedge clk)
                sync_pipe[i] <= sync_pipe[(0-1)+i];
          end
  endgenerate

  assign out[DW-1:0] = sync_pipe[N+(0-1)];
endmodule

