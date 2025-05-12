
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((((C | A) & (B & D)) | ((B & (D & A)) & (A & (C & B)))) | (B & A)) | (C & D));
endmodule

