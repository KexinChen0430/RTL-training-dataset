
module \$_OAI4_(A,B,C,D,Y);

  input  A,B,C,D;
  output Y;

  assign Y = ~(((B | (D & A)) | A) & (C | D));
endmodule

