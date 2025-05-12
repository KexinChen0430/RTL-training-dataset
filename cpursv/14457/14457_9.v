
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((((C & (D | B)) & (D | B)) & D) | (((D | B) & ((D | B) & A)) & B));
endmodule

