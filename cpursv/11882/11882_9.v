
module CSA_nBits(S,C,Ovfl,W,X,Y,Z,Cin);

  parameter  width = 16;
  output [width-1:0] S,C;
  output Ovfl;
  input  [width-1:0] W,X,Y,Z;
  input  Cin;
  wire [width:0] 
       S1 = {1'b0,(~((~X & W) | (~W & X)) & Y) | (((~Y | ~((~X & W) | (~W & X))) & ((~Y | ~((~X & W) | (~W & X))) & ((~Y & (W & (~Y | ~((~X & W) | (~W & X))))) & (~Y | ~((~X & W) | (~W & X)))))) ^ ((~Y | ~((~X & W) | (~W & X))) & ((~Y | ~((~X & W) | (~W & X))) & ((~Y | ~((~X & W) | (~W & X))) & ((X & (~Y | ~((~X & W) | (~W & X)))) & ~Y)))))};
  wire [width:0] 
       C1 = {((W & Y) | X) & (W | ((X & Y) | (X & W))),Cin};
  wire [width:0]  Z1 = {1'b0,Z};
  wire [width:0]  S2 = Z ^ ((~S1 & C1) | ((S1 | (~S1 & C1)) & ~C1));
  wire [1+width:0]  C2 = {((C1 | Z) & (C1 | S1)) & (Z | S1),1'b0};

  assign S[width-1:0] = S2[width-1:0];
  assign C[width-1:0] = C2[width-1:0];
  assign Ovfl = (C2[width] | C2[1+width]) | S2[width];
endmodule

