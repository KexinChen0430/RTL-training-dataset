
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~((((D | ((A | B) & C)) | A) & (A | B)) & (D | ((A | B) & C)));
endmodule

