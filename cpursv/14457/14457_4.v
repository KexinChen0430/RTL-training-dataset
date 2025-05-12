
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((((D & A) & (C | B)) | ((C & A) & (A & B))) | (A & B)) | (((((A | D) & C) & (C | (A & B))) & D) | ((C | (A & B)) & ((((A | D) & (C | B)) & D) & B))));
endmodule

