
module \$_XNOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ~(B ^ ((((~B | (B | A)) & A) & (~B | (B | A))) & (~B | (B | A))));
endmodule

