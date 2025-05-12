
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((((C | (D & B)) & B) | (((D & B) | A) & D)) | ((C | (A & ((D & (C | ((D & B) | A))) & (D | ((D & B) | A))))) & (((C | B) | D) & (((D & B) | A) | B))));
endmodule

