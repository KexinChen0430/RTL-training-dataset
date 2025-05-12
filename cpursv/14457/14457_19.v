
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((C & (((C | (A & B)) | (((A & B) | (B & C)) | A)) & (D | ((((D & (B & C)) | ((D & A) & C)) | (D & B)) | B)))) | ((((D & A) & C) | (A & (D & B))) | (A & B))) & ((B | (((((D & (B & C)) | ((D & A) & C)) | (D & B)) | (D & ((D | A) & C))) | C)) & (D | (A & B))));
endmodule

