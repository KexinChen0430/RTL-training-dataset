
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((((A | (D | B)) | C) & ((C | D) | A)) & ((B | ((C | D) & A)) | A)) & (((D & B) | (C | ((C | D) & A))) & ((((C | D) | A) & (((C | D) | A) & (A | (D | B)))) & (C | D))));
endmodule

