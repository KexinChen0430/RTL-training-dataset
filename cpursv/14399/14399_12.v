
module \$_OAI3_(A,B,C,Y);

  input  A,B,C;
  output Y;

  assign Y = ~((B | (A | ((A | C) & B))) & C);
endmodule

