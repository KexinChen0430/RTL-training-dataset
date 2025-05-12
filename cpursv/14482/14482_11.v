
module \$_AOI3_(A,B,C,Y);

  input  A,B,C;
  output Y;

  assign Y = ~((((A | C) & B) | (C & (B | A))) | C);
endmodule

