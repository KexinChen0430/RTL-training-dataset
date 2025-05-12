
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = (((x & y) | Cin) & y) | (((x & Cin) | (x & Cin)) | (x & y));
  assign s = ((~y & (~Cin & x)) | ((~Cin & ((((~y & ~x) & Cin) | ((~y & ~x) & (Cin | (~x & y)))) | (~x & y))) | ((~y & ~x) & Cin))) | ((((~y & (~Cin & x)) | Cin) | (~Cin & ((((~y & ~x) & Cin) | ((~y & ~x) & (Cin | (~x & y)))) | (~x & y)))) & (((x & y) | ((~Cin & ~y) & (x & y))) | (~y & (~Cin & x))));
endmodule

