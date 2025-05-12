
module CLA_4Bits(PP,GP,S,A,B,CI);

  output PP,GP;
  output [3:0] S;
  input  [3:0] A,B;
  input  CI;
  wire [3:0]  P = B | A;
  wire [3:0]  G = B & A;
  wire  C1 = (CI & (P[0] | G[0])) | G[0];
  wire  C2 = (C1 & P[1]) | G[1];
  wire  C3 = G[2] | (C2 & P[2]);
  wire [3:0]  C = {C3,C2,C1,CI};

  assign PP = &P[3:0];
  assign GP = ((P[3] & P[2]) & ((G[3] | (G[2] & P[3])) | G[1])) | ((((G[2] | G[3]) | G[0]) & ((G[0] | P[3]) | G[3])) & ((((P[3] & P[2]) & P[1]) | ((G[3] | P[3]) & G[2])) | G[3]));
  assign S = ((~C & B) & ~A) | ((~(((B & ~A) | A) & (~A | (A & ~B))) & C) | ((~B & ~C) & A));
endmodule

