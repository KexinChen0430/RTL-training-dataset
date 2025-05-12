
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((((A | C) | (D & ((((A | C) | B) & (D | (A | C))) & B))) & (C | D)) & (((B & ((D & ((((A | C) | B) & (D | (A | C))) & B)) | C)) | (A & D)) | (B | (A & C))));
endmodule

