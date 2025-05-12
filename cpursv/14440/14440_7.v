
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((A | (B | (A & D))) & ((((((D & B) | C) | B) & (A | (B | D))) & ((((D & B) | C) | D) & ((A | (B | D)) & ((((D & B) | C) | D) | A)))) & (A | ((B | D) & (((D & B) | C) | D))))) | ((B & C) | (A & D)));
endmodule

