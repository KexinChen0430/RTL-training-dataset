
module \$_OAI3_(A,B,C,Y);

  input  A,B,C;
  output Y;

  assign Y = ~((A & C) | (C & B));
endmodule

