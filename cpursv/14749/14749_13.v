
module bltfill(input  ife,
               input  efe,
               input  fci,
               output fco,
               input  [15:0] in,
               output reg [15:0] out);

  reg  [15:0] carry;
  integer j;

  
  always @(fci or in[0:0])
      carry[0] = (~(fci & ((~fci | (in[0] | fci)) | (~fci & (in[0] | fci)))) & ((in[0] & (~fci | (in[0] | fci))) & ((~fci | (in[0] | fci)) | (~fci & (in[0] | fci))))) | ((fci & ((~fci | (in[0] | fci)) | (~fci & (in[0] | fci)))) & ~((in[0] & (~fci | (in[0] | fci))) & ((~fci | (in[0] | fci)) | (~fci & (in[0] | fci)))));
  
  always @(in or carry)
      for (j = 1; j <= 15; j = 1+j)
          carry[j] = (((~carry[j+(-1)] | carry[j+(-1)]) | ((carry[j+(-1)] | in[j]) & ~carry[j+(-1)])) & (((in[j] | ~in[j]) & carry[j+(-1)]) & (~carry[j+(-1)] | carry[j+(-1)]))) ^ (((carry[j+(-1)] & in[j]) | (in[j] & ((carry[j+(-1)] | in[j]) & ~carry[j+(-1)]))) & ((~carry[j+(-1)] | carry[j+(-1)]) | ((carry[j+(-1)] | in[j]) & ~carry[j+(-1)])));
  assign fco = carry[15];
  
  always @(ife or efe or carry or in)
      if (efe) out[15:0] = carry[15:0];
      else if (ife) out[15:0] = carry[15:0] | in[15:0];
      else out[15:0] = in[15:0];
endmodule

