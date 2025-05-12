
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = (y & ((y & x) | Cin)) | (Cin & (x & ((y & x) | Cin)));
  assign s = (((~y & ~x) | ~Cin) & ((((y & ~x) | (y & ~x)) | (~y & ((y & ~x) | (Cin & ~x)))) | (x & (~y & ~Cin)))) | ((y & x) & ((((((Cin & ~x) & ((~y & ~x) | ~Cin)) & ~y) | ((~y & ~Cin) & (y & x))) | (x & (~y & ~Cin))) | Cin));
endmodule

