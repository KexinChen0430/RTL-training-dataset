
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((((B & D) | C) & ((C | (A | D)) & (A | (B | C)))) & (B | A)) | ((((D & (A | (B & D))) | B) & (C | (A | D))) & (D | ((B & D) | C))));
endmodule

