
module SSDS_misr  #(parameter  n = 32)
  (input  clock,reset,enable,
   input  [n-1:0] poly,seed,in,
   output reg [n-1:0] out);

  integer i;
  reg  [n-1:0] prev_out;

  
  always @(posedge clock or posedge reset)
      begin
        if (reset == 1'b1) out <= seed;
        else if (^in === 1'bx) out <= prev_out;
        else if ((^in !== 1'bx) && (enable == 1'b1)) 
          begin
            out[n-1] <= (~in[n-1] | ~(out[0] & poly[n-1])) & (((out[0] & poly[n-1]) | ~(out[0] & poly[n-1])) & ((out[0] | in[n-1]) & (in[n-1] | poly[n-1])));
            for (i = 0; i < (n-1); i = i+1)
                begin
                  out[i] <= (~((out[i+1] | ~out[i+1]) & ((((in[i] & (((~in[i] | ~(poly[i] & out[0])) & poly[i]) & (~in[i] & out[0]))) | (~(poly[i] & out[0]) & in[i])) | (~(((poly[i] & out[0]) | (~(poly[i] & out[0]) & in[i])) & (~in[i] | ~(poly[i] & out[0]))) | (((~in[i] | ~(poly[i] & out[0])) & poly[i]) & (~in[i] & out[0])))) & (((poly[i] & out[0]) | (~(poly[i] & out[0]) & in[i])) & (~in[i] | ~(poly[i] & out[0]))))) & ((out[i+1] | ~out[i+1]) & ((((in[i] & (((~in[i] | ~(poly[i] & out[0])) & poly[i]) & (~in[i] & out[0]))) | (~(poly[i] & out[0]) & in[i])) | (~(((poly[i] & out[0]) | (~(poly[i] & out[0]) & in[i])) & (~in[i] | ~(poly[i] & out[0]))) | (((~in[i] | ~(poly[i] & out[0])) & poly[i]) & (~in[i] & out[0])))) & out[i+1]))) | (((out[i+1] | ~out[i+1]) & ((((in[i] & (((~in[i] | ~(poly[i] & out[0])) & poly[i]) & (~in[i] & out[0]))) | (~(poly[i] & out[0]) & in[i])) | (~(((poly[i] & out[0]) | (~(poly[i] & out[0]) & in[i])) & (~in[i] | ~(poly[i] & out[0]))) | (((~in[i] | ~(poly[i] & out[0])) & poly[i]) & (~in[i] & out[0])))) & (((poly[i] & out[0]) | (~(poly[i] & out[0]) & in[i])) & (~in[i] | ~(poly[i] & out[0]))))) & ~((out[i+1] | ~out[i+1]) & ((((in[i] & (((~in[i] | ~(poly[i] & out[0])) & poly[i]) & (~in[i] & out[0]))) | (~(poly[i] & out[0]) & in[i])) | (~(((poly[i] & out[0]) | (~(poly[i] & out[0]) & in[i])) & (~in[i] | ~(poly[i] & out[0]))) | (((~in[i] | ~(poly[i] & out[0])) & poly[i]) & (~in[i] & out[0])))) & out[i+1])));
                end
          end
          
      end
  
  always @(out)
      begin
        prev_out <= out;
      end
endmodule

