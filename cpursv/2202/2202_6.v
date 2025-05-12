
module dup_stream  #(parameter  N = 1)
  (input  wire clk,
   input  wire in_valid,
   output wire in_ready,
   output wire [(-1)+N:0] out_valid,
   input  wire [(-1)+N:0] out_ready);

  
  generate
      if (N == 1) 
        begin
          assign in_ready = out_ready[0];
          assign out_valid[0] = in_valid;
        end
      else 
        begin
          reg  [0:(-1)+N] pending_prev;

          assign in_ready = ~|pending;
          assign out_valid = in_valid ? pending_prev : 0;
          wire [0:(-1)+N]  pending = ~out_ready & pending_prev;

          
          always @(posedge clk)
              begin
                pending_prev <= in_ready ? ~0 : pending;
              end
        end
  endgenerate

endmodule

