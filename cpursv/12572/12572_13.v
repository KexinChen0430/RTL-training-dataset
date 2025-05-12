
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((y & Cin) | x) & (y | ((y & Cin) | (Cin & x)));
  assign s = ((((~y & (Cin & ~x)) | y) & (~Cin & ~x)) | ((~Cin & ~y) & x)) | ((((~Cin & ~y) & x) | (y & ((Cin & x) | ((~Cin & ~y) & x)))) | (Cin & (((~y & ~x) | ((y & x) & (y & Cin))) | (Cin & (y & x)))));
endmodule

