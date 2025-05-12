
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((B | (((((B & C) | A) | B) & ((C | D) & (C | ((B & C) | A)))) | C)) & ((((C | ((B & C) | A)) | D) & ((A | D) | B)) & (C | D))) & (((B & C) | A) | B));
endmodule

