
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = (y | x) & (Cin | (((Cin | ((~y & ~Cin) & x)) | x) & y));
  assign s = (((y & x) | ((~y & ~Cin) & x)) & (Cin | ((~y & ~Cin) & x))) | (((~x & Cin) & ~y) | (((y & (x & Cin)) | (((~x & Cin) & ~y) | (~x & y))) & ~Cin));
endmodule

