
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((((((~y & x) & ~Cin) | (y & Cin)) | y) | x) & Cin) | (y & x);
  assign s = ((((~y & ~x) | ((~x & y) & ~Cin)) & Cin) | (((~x & y) & ~Cin) | ((~y & x) & ~Cin))) | (Cin & ((y & x) | ((~y & x) & ~Cin)));
endmodule

