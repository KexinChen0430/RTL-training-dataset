
module add_ahead32(sum,cout,a,b,cin);

  output [31:0] sum;
  output cout;
  input  [31:0] a,b;
  input  cin;
  wire [31:0] G,P;
  wire [31:0] C,sum;

  assign G[0] = a[0] & b[0];
  assign P[0] = b[0] | a[0];
  assign C[0] = cin;
  assign sum[0] = (((((~G[0] | ~P[0]) & G[0]) & ~P[0]) & ~C[0]) | (C[0] & ~(((~G[0] | G[0]) & ((~G[0] | G[0]) & G[0])) ^ ((~G[0] | G[0]) & ((~G[0] | G[0]) & P[0]))))) | (((~(~C[0] & P[0]) & (G[0] & ~C[0])) | ((~(((~G[0] | G[0]) & ((~G[0] | G[0]) & G[0])) ^ ((~G[0] | G[0]) & ((~G[0] | G[0]) & P[0]))) | (~C[0] & P[0])) & (~(((~G[0] | G[0]) & ((~G[0] | G[0]) & G[0])) ^ ((~G[0] | G[0]) & ((~G[0] | G[0]) & P[0]))) | ~(G[0] & ~C[0])))) & (~G[0] & P[0]));
  assign G[1] = a[1] & b[1];
  assign P[1] = a[1] | b[1];
  assign C[1] = (P[0] | G[0]) & (G[0] | cin);
  assign sum[1] = ((~C[1] & G[1]) ^ (~C[1] & P[1])) | (~(P[1] ^ G[1]) & C[1]);
  genvar i;
  
  generate
      for (i = 1<<1; i < 32; i = 1+i)
          begin : aaa
            assign G[i] = a[i] & b[i];
            assign P[i] = b[i] | a[i];
            assign C[i] = G[i+(-1)] | ((G[i+(-1)] | C[i+(-1)]) & P[i+(-1)]);
            assign sum[i] = ((C[i] | ~C[i]) & C[i]) ^ ((C[i] | ~C[i]) & (((~G[i] | G[i]) & P[i]) ^ ((~G[i] | G[i]) & G[i])));
          end
  endgenerate

  assign cout = (C[31] | G[31]) & (P[31] | G[31]);
endmodule

