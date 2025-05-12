
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((((A | C) | (B | (A & D))) & (D | C)) & ((((A | C) | D) & (A | (B | (A & D)))) & ((B | (A & D)) | D))) | ((((A | C) & (D | C)) & ((A | ((B | (A & D)) | D)) & ((A | C) | (B | (A & D))))) & (A | (B | (A & D)))));
endmodule

