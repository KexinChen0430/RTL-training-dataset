
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((y & Cin) | (y & Cin)) | ((((x | Cin) & y) | Cin) & x);
  assign s = (((y & x) & Cin) | (~Cin & (x & ~y))) | (((~x | ~Cin) & ((((y & x) & Cin) | ((y & x) & Cin)) | (~x & ((~x & y) | (Cin & ~y))))) & (~y | ~Cin));
endmodule

