
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = (y & Cin) | ((((y & x) | (y & Cin)) | Cin) & x);
  assign s = ((((Cin & ~y) & ~x) | (x & (~y & ~Cin))) | (~x & ((~Cin & y) | ((Cin & ~y) & ~x)))) | ((((~y & x) | ((y & x) & (y & Cin))) | ((x & Cin) & y)) & ((((y & (~Cin & ~x)) | (~x & ~y)) | ((x & Cin) & y)) & ((~x & ((~Cin & y) | ((Cin & ~y) & ~x))) | (Cin & ((((((y & x) | (((Cin & ~y) & ~x) & (~x & y))) | ((Cin & ~y) & ~x)) & Cin) | (((((Cin & ~y) | (~x & y)) & ~Cin) & ~x) & Cin)) | (((Cin | ((((Cin & ~y) | (~x & y)) & ~Cin) & ~x)) & (~x & ~y)) | ((y & (~Cin & ~x)) | (~y & x))))))));
endmodule

