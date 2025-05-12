
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((C | ((A & B) | (((B & D) & A) | (D & (A & C))))) & (((C & (B & D)) | (A & B)) | (((D & C) | A) & D)));
endmodule

