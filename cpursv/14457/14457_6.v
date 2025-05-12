
module \$_AOI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((((C | B) & D) | ((A & B) | ((C & (A & B)) | (((((D | A) & (C | B)) & A) | C) & (D & B))))) & ((((D | A) & (C | B)) & A) | C));
endmodule

