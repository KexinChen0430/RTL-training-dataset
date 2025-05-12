
module SSDS_misr  #(parameter  n = 32)
  (input  clock,reset,enable,inlen,
   input  [n-1:0] poly,seed,in,
   output reg [n-1:0] out);

  integer i;

  
  always @(posedge clock or posedge reset)
      begin
        if (reset == 1'b1) out <= seed;
        else if (enable == 1'b1) 
          begin
            out[n-1] <= (((in[n-1] | ~in[n-1]) & (in[n-1] & (~(poly[n-1] & out[0]) | ~in[n-1]))) & ~((in[n-1] | ~in[n-1]) & ((poly[n-1] & out[0]) & (~(poly[n-1] & out[0]) | ~in[n-1])))) | (~((in[n-1] | ~in[n-1]) & (in[n-1] & (~(poly[n-1] & out[0]) | ~in[n-1]))) & ((in[n-1] | ~in[n-1]) & ((poly[n-1] & out[0]) & (~(poly[n-1] & out[0]) | ~in[n-1]))));
            for (i = 0; i < (n-1); i = i+1)
                begin
                  out[i] <= (((~(poly[i] & out[0]) & (in[i] & ~out[i+1])) | ~((((poly[i] & out[0]) | ~(poly[i] & out[0])) & (poly[i] & out[0])) ^ (((poly[i] & out[0]) | ~(poly[i] & out[0])) & in[i]))) | (((out[0] & ~in[i]) & poly[i]) & ~out[i+1])) & (((out[i+1] | ~out[i+1]) & ((~(poly[i] & out[0]) & in[i]) | out[i+1])) | (((out[0] & ~in[i]) & poly[i]) & ~out[i+1]));
                end
          end
          
      end
endmodule

