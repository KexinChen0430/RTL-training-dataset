
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((A | B) & ((D | C) & ((A | B) | (A | D))));
endmodule

