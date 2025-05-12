
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((x & y) | (y & (((x & y) | ((~x & (Cin & ~x)) & ~y)) | Cin))) | ((x & Cin) | (x & y));
  assign s = ((y & (x & Cin)) | (((~x & (Cin & ~x)) & ~y) | ((x & (~Cin & (x | y))) & ~y))) | (~x & ((~Cin & y) | (y & (x & Cin))));
endmodule

