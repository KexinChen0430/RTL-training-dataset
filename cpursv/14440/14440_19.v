
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((((((A & D) | ((B & (D | (A | C))) & C)) | B) | A) & (((B | D) | ((C & (D | A)) & A)) & ((B | ((A & D) | C)) | A))) & (C | D));
endmodule

