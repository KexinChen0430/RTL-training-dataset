
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((((A & D) & ((A | D) & C)) | ((((A & D) & ((A | D) & C)) | (((A & B) & (D & B)) & C)) | ((A & B) & (D & B)))) | (A & B)) | (((A | D) & C) & D));
endmodule

