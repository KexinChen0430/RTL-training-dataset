
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((((B | A) & ((D | ((C | A) | B)) & (C | A))) | ((C & A) | (B & D))) & ((D | C) & ((B | C) | (A & D))));
endmodule

