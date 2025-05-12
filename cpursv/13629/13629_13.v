
module SSDS_misr  #(parameter  n = 32)
  (input  clock,reset,enable,
   input  [(-1)+n:0] poly,seed,in,
   output reg [(-1)+n:0] out);

  integer i;
  reg  [(-1)+n:0] prev_out;

  
  always @(posedge clock or posedge reset)
      begin
        if (reset == 1'b1) out <= seed;
        else if (^in === 1'bx) out <= prev_out;
        else if ((enable == 1'b1) && (^in !== 1'bx)) 
          begin
            out[(-1)+n] <= ((~(out[0] & poly[(-1)+n]) | (out[0] & poly[(-1)+n])) & ((~(out[0] & poly[(-1)+n]) | ~in[(-1)+n]) & (out[0] & poly[(-1)+n]))) ^ ((~(out[0] & poly[(-1)+n]) | (out[0] & poly[(-1)+n])) & ((in[(-1)+n] & ~in[(-1)+n]) | (~(out[0] & poly[(-1)+n]) & in[(-1)+n])));
            for (i = 0; i < ((-1)+n); i = i+1)
                begin
                  out[i] <= ((((~in[i] & ~out[i+1]) & (out[0] & poly[i])) | (~((out[0] & poly[i]) ^ in[i]) | (~out[i+1] & (~(out[0] & poly[i]) & in[i])))) & ((((~(out[0] & poly[i]) & in[i]) | ~((out[0] & poly[i]) ^ in[i])) | (~in[i] & ((~(out[0] & poly[i]) & in[i]) | (out[0] & poly[i])))) & out[i+1])) ^ ((((~in[i] & ~out[i+1]) & (out[0] & poly[i])) | (~((out[0] & poly[i]) ^ in[i]) | (~out[i+1] & (~(out[0] & poly[i]) & in[i])))) & ((((~(out[0] & poly[i]) & in[i]) | ~((out[0] & poly[i]) ^ in[i])) | (~in[i] & ((~(out[0] & poly[i]) & in[i]) | (out[0] & poly[i])))) & ((out[0] & poly[i]) ^ in[i])));
                end
          end
          
      end
  
  always @(out)
      begin
        prev_out <= out;
      end
endmodule

