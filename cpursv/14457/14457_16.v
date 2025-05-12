
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((A & ((A | D) & B)) | ((A | (D & C)) & ((D & C) | (B & D))));
endmodule

