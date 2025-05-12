
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((((C & ((C | A) & D)) | (B & (D | A))) & C) | ((((((((D & A) & C) | B) | D) & (C | A)) & A) & B) | ((C | B) & (D & A))));
endmodule

