
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((x & Cin) | (Cin & y)) | (y & (Cin | (x & y)));
  assign s = ((((~Cin | ~Cin) | (~y & ~x)) & (~x & y)) | ((((~x & ((Cin | (~x & y)) & ((~x & y) | (~y & ~x)))) & (~y & Cin)) | ((~Cin & ~y) & (x & y))) | (~Cin & (~y & x)))) | (Cin & (x & y));
endmodule

