
module Mac  #(parameter  D_BITS = 8, W_BITS = 8, A_BITS = 16)
  (input  clock,
   input  reset,
   input  set_w,
   input  stall,
   input  [A_BITS+(-1):0] a_in,
   input  [(-1)+D_BITS:0] d_in,
   output reg [A_BITS+(-1):0] a_out,
   output reg [(-1)+D_BITS:0] d_out);

  reg  [(-1)+W_BITS:0] w;

  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            a_out <= {A_BITS{1'b0}};
            d_out <= {D_BITS{1'b0}};
          end
        else if (!stall) 
          begin
            if (set_w) 
              begin
                w <= a_in;
                a_out <= a_in;
              end
            else 
              begin
                a_out <= a_in+(d_in*w);
                d_out <= d_in;
              end
          end
          
      end
endmodule

