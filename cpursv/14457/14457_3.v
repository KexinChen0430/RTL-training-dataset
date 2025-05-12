
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((((D & C) | ((D & B) | (((B & A) | ((A & C) | ((D & C) & (B & A)))) & (D & C)))) & A) | ((B & A) | (B & (D & C)))) | (D & C));
endmodule

