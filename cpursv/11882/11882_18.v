
module CSA_nBits(S,C,Ovfl,W,X,Y,Z,Cin);

  parameter  width = 16;
  output [(0-1)+width:0] S,C;
  output Ovfl;
  input  [(0-1)+width:0] W,X,Y,Z;
  input  Cin;
  wire [width:0] 
       S1 = {1'b0,(~((~W & X) | ((~W | ~X) & W)) & Y) | ((((~((~W & X) | ((~W | ~X) & W)) | ~Y) & ((~((~W & X) | ((~W | ~X) & W)) | ~Y) & ((((~Y & (~W & X)) | (Y | ((~X & W) & ~Y))) & (((~Y & (~W & X)) | (Y | ((~X & W) & ~Y))) & ((~Y & X) & (~((~W & X) | ((~W | ~X) & W)) | ~Y)))) & ((~Y & (~W & X)) | (Y | ((~X & W) & ~Y)))))) & ~((~((~W & X) | ((~W | ~X) & W)) | ~Y) & ((~((~W & X) | ((~W | ~X) & W)) | ~Y) & (((~Y & (~W & X)) | (Y | ((~X & W) & ~Y))) & ((((~((~W & X) | ((~W | ~X) & W)) | ~Y) & (W & ~Y)) & ((~Y & (~W & X)) | (Y | ((~X & W) & ~Y)))) & ((~Y & (~W & X)) | (Y | ((~X & W) & ~Y)))))))) | (~((~((~W & X) | ((~W | ~X) & W)) | ~Y) & ((~((~W & X) | ((~W | ~X) & W)) | ~Y) & ((((~Y & (~W & X)) | (Y | ((~X & W) & ~Y))) & (((~Y & (~W & X)) | (Y | ((~X & W) & ~Y))) & ((~Y & X) & (~((~W & X) | ((~W | ~X) & W)) | ~Y)))) & ((~Y & (~W & X)) | (Y | ((~X & W) & ~Y)))))) & ((~((~W & X) | ((~W | ~X) & W)) | ~Y) & ((~((~W & X) | ((~W | ~X) & W)) | ~Y) & (((~Y & (~W & X)) | (Y | ((~X & W) & ~Y))) & ((((~((~W & X) | ((~W | ~X) & W)) | ~Y) & (W & ~Y)) & ((~Y & (~W & X)) | (Y | ((~X & W) & ~Y)))) & ((~Y & (~W & X)) | (Y | ((~X & W) & ~Y)))))))))};
  wire [width:0]  C1 = {(W & Y) | ((W & X) | (X & Y)),Cin};
  wire [width:0]  Z1 = {1'b0,Z};
  wire [width:0] 
       S2 = (~(C1 ^ S1) & Z) | (((~Z & ~(C1 & ~Z)) & S1) | (~(S1 & ~Z) & (C1 & ~Z)));
  wire [1+width:0] 
       C2 = {((((C1 | Z) | (C1 & Z)) & ((C1 & Z) | (Z | S1))) & C1) | (S1 & ((S1 | C1) & Z)),1'b0};

  assign S[(0-1)+width:0] = S2[(0-1)+width:0];
  assign C[(0-1)+width:0] = C2[(0-1)+width:0];
  assign Ovfl = (C2[1+width] | C2[width]) | S2[width];
endmodule

