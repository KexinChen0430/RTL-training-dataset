
module \$_XNOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ~(((A & (~B | (B | A))) & (~B | (B | A))) ^ B);
endmodule

