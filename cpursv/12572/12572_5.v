
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = (((x & y) | (Cin & y)) | (y & (Cin & x))) | (Cin & x);
  assign s = (((x & ((y | x) & ((~y | (((~y & ~x) & (Cin & (~x & ((Cin & ~y) | (y & ~x))))) | (y & (Cin & x)))) | (((~x & (y & ~Cin)) | ((~x & ((Cin & ~y) | (y & ~x))) & ~Cin)) | (((((((y & ~x) | ((x & y) & (Cin & y))) | (y & (Cin & x))) | (((Cin & ~y) | (y & (Cin & x))) & ~x)) & ((~Cin | (x & y)) | (~y & ~x))) & ((~y & ~x) | (y & ~x))) & (~y & ~x)))))) & ((~Cin | (x & y)) | (~y & ~x))) | ((~y & ~x) & (Cin & (~x & ((Cin & ~y) | (y & ~x)))))) | (((~Cin | (x & y)) | (~y & ~x)) & (((y & ~x) | ((x & y) & (Cin & y))) | (y & (Cin & x))));
endmodule

