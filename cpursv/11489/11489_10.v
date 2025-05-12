
module oh_delay  #(parameter  DW = 1, N = 1)
  (input  [(-1)+DW:0] in,
   input  clk,
   output [(-1)+DW:0] out);

  reg  [(-1)+DW:0] sync_pipe[N+(-1):0];

  genvar i;
  
  generate
      
      always @(posedge clk)
          sync_pipe[0] <= in[(-1)+DW:0];
      for (i = 1; i < N; i = i+1)
          begin : gen_pipe
            
            always @(posedge clk)
                sync_pipe[i] <= sync_pipe[i+(-1)];
          end
  endgenerate

  assign out[(-1)+DW:0] = sync_pipe[N+(-1)];
endmodule

