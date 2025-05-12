
module SSDS_misr  #(parameter  n = 32)
  (input  clock,reset,enable,inlen,
   input  [(0-1)+n:0] poly,seed,in,
   output reg [(0-1)+n:0] out);

  integer i;

  
  always @(posedge clock or posedge reset)
      begin
        if (reset == 1'b1) out <= seed;
        else if (enable == 1'b1) 
          begin
            out[(0-1)+n] <= (in[(0-1)+n] & ((poly[(0-1)+n] | ~(out[0] & poly[(0-1)+n])) & (~(out[0] & poly[(0-1)+n]) | (~in[(0-1)+n] & out[0])))) | ((out[0] & poly[(0-1)+n]) & ~in[(0-1)+n]);
            for (i = 0; i < ((0-1)+n); i = 1+i)
                begin
                  out[i] <= (~(((~out[1+i] & ~(poly[i] & out[0])) | (((~out[1+i] & ~in[i]) | ~((~(poly[i] & out[0]) | ~in[i]) & ((((~in[i] & out[0]) | in[i]) & in[i]) | (((~in[i] & out[0]) | in[i]) & poly[i])))) & (~((~(poly[i] & out[0]) | ~in[i]) & ((((~in[i] & out[0]) | in[i]) & in[i]) | (((~in[i] & out[0]) | in[i]) & poly[i]))) | (poly[i] & out[0])))) & ((~out[1+i] | out[1+i]) & out[1+i])) & (((~out[1+i] & ~(poly[i] & out[0])) | (((~out[1+i] & ~in[i]) | ~((~(poly[i] & out[0]) | ~in[i]) & ((((~in[i] & out[0]) | in[i]) & in[i]) | (((~in[i] & out[0]) | in[i]) & poly[i])))) & (~((~(poly[i] & out[0]) | ~in[i]) & ((((~in[i] & out[0]) | in[i]) & in[i]) | (((~in[i] & out[0]) | in[i]) & poly[i]))) | (poly[i] & out[0])))) & ((~out[1+i] | out[1+i]) & ((~(poly[i] & out[0]) | ~in[i]) & ((((~in[i] & out[0]) | in[i]) & in[i]) | (((~in[i] & out[0]) | in[i]) & poly[i])))))) | ((((~out[1+i] & ~(poly[i] & out[0])) | (((~out[1+i] & ~in[i]) | ~((~(poly[i] & out[0]) | ~in[i]) & ((((~in[i] & out[0]) | in[i]) & in[i]) | (((~in[i] & out[0]) | in[i]) & poly[i])))) & (~((~(poly[i] & out[0]) | ~in[i]) & ((((~in[i] & out[0]) | in[i]) & in[i]) | (((~in[i] & out[0]) | in[i]) & poly[i]))) | (poly[i] & out[0])))) & ((~out[1+i] | out[1+i]) & out[1+i])) & ~(((~out[1+i] & ~(poly[i] & out[0])) | (((~out[1+i] & ~in[i]) | ~((~(poly[i] & out[0]) | ~in[i]) & ((((~in[i] & out[0]) | in[i]) & in[i]) | (((~in[i] & out[0]) | in[i]) & poly[i])))) & (~((~(poly[i] & out[0]) | ~in[i]) & ((((~in[i] & out[0]) | in[i]) & in[i]) | (((~in[i] & out[0]) | in[i]) & poly[i]))) | (poly[i] & out[0])))) & ((~out[1+i] | out[1+i]) & ((~(poly[i] & out[0]) | ~in[i]) & ((((~in[i] & out[0]) | in[i]) & in[i]) | (((~in[i] & out[0]) | in[i]) & poly[i]))))));
                end
          end
          
      end
endmodule

