
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((((B & ((D | A) & (C | B))) & A) | ((((B & D) & A) | ((C & B) & D)) | (((C & B) & (D | A)) & A))) | ((C & D) | (((C & B) & D) | (((C & B) & (D | A)) & A))));
endmodule

