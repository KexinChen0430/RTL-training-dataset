
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((A & (D | B)) | (C & D)) & (B | (((((A & D) & B) | (((A & D) & C) | ((B & (A & C)) & D))) | C) | (D & B))));
endmodule

