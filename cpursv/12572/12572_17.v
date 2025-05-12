
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((x & y) | ((x & Cin) & y)) | ((x & Cin) | (Cin & y));
  assign s = ((~Cin & ((~y & (y | x)) & x)) | ((~x & Cin) & (~x & ~y))) | (((~Cin & ((~x & Cin) & (~x & ~y))) | (~Cin & (~x & y))) | ((x & Cin) & y));
endmodule

