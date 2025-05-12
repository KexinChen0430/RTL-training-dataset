
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((D & C) | ((C & (B & D)) | (((D & A) & B) | ((D & C) & A)))) | ((A & (B & (C | A))) | ((C & (B & D)) | ((B & (((A | D) & C) & A)) | (C & (B & D))))));
endmodule

