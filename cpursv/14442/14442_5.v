
module \$_XNOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ~((((~A & (~B | B)) | (A ^ (A & B))) & B) ^ (A ^ (A & B)));
endmodule

