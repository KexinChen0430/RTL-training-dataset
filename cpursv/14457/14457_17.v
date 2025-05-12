
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((C | ((((((D & B) & C) | (B & (C & A))) | (D & C)) | B) | ((((D & B) & C) | (B & (C & A))) | (D & C)))) & (A | (D & C))) & ((((A & (D & B)) | (B & (C & A))) | ((D & B) | (D & C))) | (B & A)));
endmodule

