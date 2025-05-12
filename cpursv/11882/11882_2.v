
module CSA_nBits(S,C,Ovfl,W,X,Y,Z,Cin);

  parameter  width = 16;
  output [(-1)+width:0] S,C;
  output Ovfl;
  input  [(-1)+width:0] W,X,Y,Z;
  input  Cin;
  wire [width:0] 
       S1 = {1'b0,((Y | (~((~Y & (W | X)) & W) & (X & ~Y))) | (W & (~(X & ~Y) & ~Y))) & ((Y & ~(W ^ X)) | ~Y)};
  wire [width:0]  C1 = {((W | X) & (X | Y)) & (Y | W),Cin};
  wire [width:0]  Z1 = {1'b0,Z};
  wire [width:0] 
       S2 = (Z & ~((C1 & ~S1) | (S1 & ~C1))) | (((~((C1 & ~S1) | (S1 & ~C1)) | ~Z) & (((Z | (~Z & ((S1 & ~C1) | ~S1))) & ((C1 | S1) | Z)) & ((~((C1 & ~S1) | (S1 & ~C1)) | ~Z) & (((Z | (~Z & ((S1 & ~C1) | ~S1))) & ((C1 | S1) | Z)) & ((((Z | (~Z & ((S1 & ~C1) | ~S1))) & ((C1 | S1) | Z)) & (~Z & C1)) & ((Z | (~Z & ((S1 & ~C1) | ~S1))) & ((C1 | S1) | Z))))))) ^ ((~((C1 & ~S1) | (S1 & ~C1)) | ~Z) & (((Z | (~Z & ((S1 & ~C1) | ~S1))) & ((C1 | S1) | Z)) & ((~((C1 & ~S1) | (S1 & ~C1)) | ~Z) & (((Z | (~Z & ((S1 & ~C1) | ~S1))) & ((C1 | S1) | Z)) & (((S1 & (~Z & (C1 | S1))) & ((Z | (~Z & ((S1 & ~C1) | ~S1))) & ((C1 | S1) | Z))) & ((Z | (~Z & ((S1 & ~C1) | ~S1))) & ((C1 | S1) | Z))))))));
  wire [width+1:0]  C2 = {(C1 | S1) & ((C1 & (Z | S1)) | Z),1'b0};

  assign S[(-1)+width:0] = S2[(-1)+width:0];
  assign C[(-1)+width:0] = C2[(-1)+width:0];
  assign Ovfl = C2[width] | (S2[width] | C2[width+1]);
endmodule

