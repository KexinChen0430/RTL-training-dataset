
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((((Cin & y) | (Cin & y)) | (y & x)) | x) & (Cin | (((Cin & y) | (Cin & y)) | (y & x)));
  assign s = (((x & (~Cin & ~y)) | (x & (~Cin & ~y))) | (((((x & (~Cin & ~y)) | (y & ((x & (~Cin & ~y)) | (x & Cin)))) | Cin) | (y & ((~Cin & ~x) | ((~x & Cin) & (~x & ~y))))) & ((~y | (~Cin & (((y & ~x) | (Cin & ~y)) & ~x))) & ~x))) | (((((~x & Cin) & (~x & ~y)) | (x & (~Cin & ~y))) | ((((~x & Cin) & (~x & ~y)) | y) & ((((~x & Cin) & (~x & ~y)) | x) | (~Cin & ((((y & ~x) | (Cin & ~y)) & ~x) | (Cin & (y & x))))))) & (((x & (~Cin & ~y)) | (y & ((x & (~Cin & ~y)) | (x & Cin)))) | Cin));
endmodule

