
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((C & D) | ((C & (A & (B & D))) | ((B & C) & (A | D)))) | (((((A & B) | C) & B) & D) | (A & B)));
endmodule

