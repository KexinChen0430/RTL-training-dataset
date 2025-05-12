
module CSA_nBits(S,C,Ovfl,W,X,Y,Z,Cin);

  parameter  width = 16;
  output [width+(0-1):0] S,C;
  output Ovfl;
  input  [width+(0-1):0] W,X,Y,Z;
  input  Cin;
  wire [width:0] 
       S1 = {1'b0,((Y | (W | X)) & (((~W | ~X) & ~Y) | Y)) & (~Y | (Y & ~((W | ((X & ~W) | (W & X))) & (~W | ~X))))};
  wire [width:0]  C1 = {(Y | W) & ((W | X) & (Y | X)),Cin};
  wire [width:0]  Z1 = {1'b0,Z};
  wire [width:0]  S2 = Z ^ (S1 ^ C1);
  wire [width+1:0] 
       C2 = {((C1 | Z) & (S1 | Z)) & ((S1 | C1) & (C1 | Z)),1'b0};

  assign S[width+(0-1):0] = S2[width+(0-1):0];
  assign C[width+(0-1):0] = C2[width+(0-1):0];
  assign Ovfl = (S2[width] | C2[width+1]) | C2[width];
endmodule

