
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = (x & (Cin | y)) | ((y & Cin) | ((x & (Cin | y)) & y));
  assign s = ((((~Cin & y) & ~x) | ((~y & ~Cin) & x)) | (((Cin & ~x) | ((~Cin & y) & ~x)) & ~y)) | (((~x & (Cin & ~y)) | (Cin & (((~Cin & y) & ~x) | (Cin & ((~x & ~y) | ((~Cin & y) & ~x)))))) | ((y & (((((~Cin & y) & ~x) | ((x & (Cin | y)) & y)) | x) | (~x & (Cin & ~y)))) & Cin));
endmodule

