
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((A & B) | (B & ((D | A) & C))) | ((C & D) | ((A & ((((D & B) | (((C & D) & B) | (((D | A) & C) & (A & D)))) | (D & (A & (B & ((D | A) & C))))) | (C & D))) | (A & (B & ((D | A) & C))))));
endmodule

