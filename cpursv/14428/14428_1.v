
module \$_NOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ~(A | B);
endmodule

