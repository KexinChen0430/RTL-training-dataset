
module CSA_nBits(S,C,Ovfl,W,X,Y,Z,Cin);

  parameter  width = 16;
  output [width-1:0] S,C;
  output Ovfl;
  input  [width-1:0] W,X,Y,Z;
  input  Cin;
  wire [width:0] 
       S1 = {1'b0,((~W & X) | (~X & (((~W & X) | ~X) & W))) ^ Y};
  wire [width:0]  C1 = {(Y & (X | W)) | (X & W),Cin};
  wire [width:0]  Z1 = {1'b0,Z};
  wire [width:0]  S2 = ((S1 | C1) & (~C1 | ~S1)) ^ Z;
  wire [1+width:0]  C2 = {(C1 & S1) | ((Z & S1) | (C1 & Z)),1'b0};

  assign S[width-1:0] = S2[width-1:0];
  assign C[width-1:0] = C2[width-1:0];
  assign Ovfl = (C2[1+width] | C2[width]) | S2[width];
endmodule

