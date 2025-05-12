
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((((C & D) | ((B & (A & C)) | (B & (C & D)))) | ((((A | C) & B) & D) | (C & D))) | ((B & (C & D)) | (A & ((A | C) & B))));
endmodule

