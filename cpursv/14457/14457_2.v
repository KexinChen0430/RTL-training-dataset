
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((C & D) | ((((C | A) & B) & (C & A)) | ((((D & A) & C) | ((B & (D & A)) & C)) | (B & (D & A))))) | ((((C | B) & (((((C | A) & B) & (C & A)) | D) | A)) & B) & ((C | B) & A)));
endmodule

