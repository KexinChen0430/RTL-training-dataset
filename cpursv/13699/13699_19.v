
module SSDS_misr  #(parameter  n = 32)
  (input  clock,reset,enable,inlen,
   input  [(-1)+n:0] poly,seed,in,
   output reg [(-1)+n:0] out);

  integer i;

  
  always @(posedge clock or posedge reset)
      begin
        if (reset == 1'b1) out <= seed;
        else if (enable == 1'b1) 
          begin
            out[(-1)+n] <= ((~in[(-1)+n] | in[(-1)+n]) & ((in[(-1)+n] & ((((~(out[0] & poly[(-1)+n]) | (out[0] & poly[(-1)+n])) & ~(out[0] & poly[(-1)+n])) | ((~(out[0] & poly[(-1)+n]) | (out[0] & poly[(-1)+n])) & ~in[(-1)+n])) & (~(out[0] & poly[(-1)+n]) | out[0]))) & (poly[(-1)+n] | ~(out[0] & poly[(-1)+n])))) ^ ((~in[(-1)+n] | in[(-1)+n]) & ((out[0] & poly[(-1)+n]) & (((~(out[0] & poly[(-1)+n]) | (out[0] & poly[(-1)+n])) & ~(out[0] & poly[(-1)+n])) | ((~(out[0] & poly[(-1)+n]) | (out[0] & poly[(-1)+n])) & ~in[(-1)+n]))));
            for (i = 0; i < ((-1)+n); i = i+1)
                begin
                  out[i] <= ((((((~(poly[i] & out[0]) & in[i]) & ~out[i+1]) | out[i+1]) | (~out[i+1] & (~in[i] & poly[i]))) & ((((~(poly[i] & out[0]) & in[i]) & ~out[i+1]) | out[i+1]) | out[0])) & ((~(((in[i] | ~in[i]) & (poly[i] & out[0])) ^ ((in[i] | ~in[i]) & in[i])) | (~out[i+1] & (~in[i] & out[0]))) & (~(((in[i] | ~in[i]) & (poly[i] & out[0])) ^ ((in[i] | ~in[i]) & in[i])) | poly[i]))) | ((((((~(poly[i] & out[0]) & in[i]) & ~out[i+1]) | out[i+1]) | (~out[i+1] & (~in[i] & poly[i]))) & ((((~(poly[i] & out[0]) & in[i]) & ~out[i+1]) | out[i+1]) | out[0])) & ((~(poly[i] & out[0]) & in[i]) & ~out[i+1]));
                end
          end
          
      end
endmodule

