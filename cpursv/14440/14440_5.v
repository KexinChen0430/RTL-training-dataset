
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((D | C) & B) | (((A | D) & ((A | ((D & A) | B)) & (((C | A) | B) & (C | (B | D))))) & ((D | C) & ((D | (C | A)) & (((D | ((C | A) | B)) & (C | (B | D))) & ((A | D) | (A | ((D & A) | B))))))));
endmodule

