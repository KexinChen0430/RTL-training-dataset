
module dup_Array  #(parameter  N = 1)
  (input  wire clk,
   input  wire in_valid,
   output wire in_ready,
   output wire [0:(-1)+N] out_valid,
   input  wire [0:(-1)+N] out_ready);

  
  generate
      if (N == 1) 
        begin
          assign in_ready = out_ready;
          assign out_valid = in_valid;
        end
      else 
        begin
          reg  [0:(-1)+N] done;

          assign in_ready = |out_ready;
          assign out_valid = in_valid ? (pending & ~(pending-1)) : 0;
          wire [0:(-1)+N]  pending = out_ready & ~done;

          
          always @(posedge clk)
              begin
                done <= (~out_valid & pending) ? (out_valid | done) : 0;
              end
        end
  endgenerate

endmodule

