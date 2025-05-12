
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
            out[n-1] <= (~in[n-1] & ((~in[n-1] | ~(out[0] & poly[n-1])) & (out[0] & poly[n-1]))) | ((in[n-1] & (~in[n-1] & ((~in[n-1] | ~(out[0] & poly[n-1])) & (out[0] & poly[n-1])))) | (in[n-1] & ~(out[0] & poly[n-1])));
            for (i = 0; i < (n-1); i = 1+i)
                begin
                  out[i] <= (((~((~((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & (out[0] & poly[i]))) & ((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & in[i]))) | (((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & (out[0] & poly[i]))) & ~((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & in[i])))) | ~out[1+i]) & (out[0] & poly[i])) ^ ((~((~((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & (out[0] & poly[i]))) & ((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & in[i]))) | (((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & (out[0] & poly[i]))) & ~((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & in[i])))) | ~out[1+i]) & in[i])) ^ ((out[1+i] & ~out[1+i]) | (out[1+i] & ~((~((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & (out[0] & poly[i]))) & ((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & in[i]))) | (((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & (out[0] & poly[i]))) & ~((~in[i] | ~(out[0] & poly[i])) & (((poly[i] | ~(out[0] & poly[i])) & (out[0] | ~(out[0] & poly[i]))) & in[i]))))));
                end
          end
          
      end
endmodule

