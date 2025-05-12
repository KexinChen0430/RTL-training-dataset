
module \$_ORNOT_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ~B | A;
endmodule

