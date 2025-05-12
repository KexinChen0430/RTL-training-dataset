
module \$_OAI3_(A,B,C,Y);

  input  A,B,C;
  output Y;

  assign Y = ~(C & ((C | A) & (A | B)));
endmodule

