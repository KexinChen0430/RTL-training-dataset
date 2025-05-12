
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((((B & (D | C)) & D) | (A | ((((D | A) & (C & (B | (D | A)))) & A) | ((C & (B | (D | A))) & (B & (D | C)))))) & (((B | ((((D | A) & (C & (B | (D | A)))) & A) | ((B & (D | C)) & D))) | (A | ((((D | A) & (C & (B | (D | A)))) & A) | ((C & (B | (D | A))) & (B & (D | C)))))) & ((D | (C | A)) & (D | (C | B))))) & (D | C));
endmodule

