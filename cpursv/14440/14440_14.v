
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((A | B) & (((((A | (D | B)) & (((C | D) | A) & (((C | B) | A) | (A | (D | B))))) & (C | D)) & (((C | D) | A) & ((C | B) | A))) & (((A | (D | B)) & (((C | D) | A) & (((C | B) | A) | (A | (D | B))))) & (C | D))));
endmodule

