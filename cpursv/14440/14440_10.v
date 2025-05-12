
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((((A | C) & (D | C)) & ((((B | (A | C)) | (A | (D | B))) & (D | (A | C))) & (B | A))) | ((((B | A) & ((A | (D | B)) & C)) | (((((B | (A | C)) & (C | (D | B))) & D) & B) | (B & ((A | (D | B)) & C)))) & D));
endmodule

