
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((x & Cin) | (x & Cin)) | ((x & y) | (y & Cin));
  assign s = ((((x & y) & (((((~x & ~y) | (~x & y)) & Cin) | (~x & y)) | Cin)) | ((Cin & ~x) & (~x & ~y))) | (~Cin & ((((~x & ~y) | (~x & y)) & Cin) | (~x & y)))) | (~y & (((x & ~Cin) | ((~y & (((Cin & ~x) | ((x & y) & (y & Cin))) | ((x & y) & Cin))) | ((x & y) & Cin))) | (~x & (y & ((~Cin | ~Cin) | (~y & ((((~x & ~y) | (~x & y)) & Cin) | (~x & y))))))));
endmodule

