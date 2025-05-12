
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((Cin | ((y & Cin) | (x & y))) & x) | (y & (Cin | ((y & Cin) | (x & y))));
  assign s = (((~x & ~Cin) & y) | ((x & ~y) & (((x & y) | ~Cin) | ((((((~x & ~Cin) & y) | (~y & ~x)) & Cin) | ((~x & ~Cin) & y)) & Cin)))) | ((((((~x & ~Cin) & y) | (~y & ~x)) & Cin) | ((~x & ~Cin) & y)) | (((x & (y & Cin)) | (x & (y & Cin))) | (((((y & ~x) | (Cin & ~x)) & ~y) | (y & ~x)) & (Cin & ~y))));
endmodule

