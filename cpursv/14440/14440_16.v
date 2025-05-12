
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((B | ((B & D) | A)) & (B | (((A & ((B | ((B & D) | C)) | D)) & (((B & D) | C) | D)) | C))) & ((((B & D) | A) | (B | ((B & D) | C))) & (((B & D) | C) | D)));
endmodule

