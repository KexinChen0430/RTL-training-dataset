
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((A & (((((D | B) | (A | B)) | ((A | B) | (A | C))) & ((D | (B & C)) | ((A | B) & (B | C)))) & (A | B))) & (((((D | B) | (A | B)) | ((A | B) | (A | C))) & (A | D)) & (C | D))) | ((((C | (A | D)) & ((A | B) | (A | C))) & (C | D)) & ((D & A) | B)));
endmodule

