
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((B & A) | ((D | (A | ((A & D) | ((C & (D & B)) | (A & (C & D)))))) & (C & ((A | C) & (D | B)))));
endmodule

