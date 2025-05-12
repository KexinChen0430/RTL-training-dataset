
module CSA_nBits(S,C,Ovfl,W,X,Y,Z,Cin);

  parameter  width = 16;
  output [(0-1)+width:0] S,C;
  output Ovfl;
  input  [(0-1)+width:0] W,X,Y,Z;
  input  Cin;
  wire [width:0] 
       S1 = {1'b0,(~((~X & ((X & ~W) | W)) | (X & ~W)) & Y) | (((~((~X & ((X & ~W) | W)) | (X & ~W)) | ~Y) & ((((X & ~Y) & ~(W & ~Y)) | (Y | ((~(X & ~Y) & ~Y) & W))) & ((~((~X & ((X & ~W) | W)) | (X & ~W)) | ~Y) & ((((X & ~Y) & ~(W & ~Y)) | (Y | ((~(X & ~Y) & ~Y) & W))) & ((((X & ~Y) & ~(W & ~Y)) | (Y | ((~(X & ~Y) & ~Y) & W))) & (((~((~X & ((X & ~W) | W)) | (X & ~W)) | ~Y) & (X & ~Y)) & (~((~X & ((X & ~W) | W)) | (X & ~W)) | ~Y))))))) ^ ((~((~X & ((X & ~W) | W)) | (X & ~W)) | ~Y) & ((((X & ~Y) & ~(W & ~Y)) | (Y | ((~(X & ~Y) & ~Y) & W))) & ((~((~X & ((X & ~W) | W)) | (X & ~W)) | ~Y) & ((((X & ~Y) & ~(W & ~Y)) | (Y | ((~(X & ~Y) & ~Y) & W))) & (((~((~X & ((X & ~W) | W)) | (X & ~W)) | ~Y) & ((W & ~Y) & (~((~X & ((X & ~W) | W)) | (X & ~W)) | ~Y))) & (((X & ~Y) & ~(W & ~Y)) | (Y | ((~(X & ~Y) & ~Y) & W)))))))))};
  wire [width:0]  C1 = {((Y | W) & (W | X)) & (X | (W & Y)),Cin};
  wire [width:0]  Z1 = {1'b0,Z};
  wire [width:0] 
       S2 = (~Z | (Z & ~(C1 ^ S1))) & ((((~C1 | ~S1) & ~Z) | Z) & (Z | (S1 | C1)));
  wire [width+1:0] 
       C2 = {((S1 & Z) | (S1 & C1)) | (((S1 | C1) & (Z | S1)) & C1),1'b0};

  assign S[(0-1)+width:0] = S2[(0-1)+width:0];
  assign C[(0-1)+width:0] = C2[(0-1)+width:0];
  assign Ovfl = (C2[width] | C2[width+1]) | S2[width];
endmodule

