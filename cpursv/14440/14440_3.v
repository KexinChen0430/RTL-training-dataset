
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((((B | (C | D)) & (((((D | B) | A) & (C | B)) & (B | A)) | (C | A))) & (C | D)) & (A | (D & B))) | ((B | A) & C));
endmodule

