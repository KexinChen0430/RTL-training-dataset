
module dup_Array  #(parameter  N = 1)
  (input  wire clk,
   input  wire in_valid,
   output wire in_ready,
   output wire [0:N+(0-1)] out_valid,
   input  wire [0:N+(0-1)] out_ready);

  
  generate
      if (N == 1) 
        begin
          assign in_ready = out_ready;
          assign out_valid = in_valid;
        end
      else 
        begin
          reg  [0:N+(0-1)] done;

          assign in_ready = |out_ready;
          assign out_valid = in_valid ? (~((0-1)+pending) & pending) : 0;
          wire [0:N+(0-1)]  pending = ~done & out_ready;

          
          always @(posedge clk)
              begin
                done <= (pending & ~out_valid) ? (done | out_valid) : 0;
              end
        end
  endgenerate

endmodule

