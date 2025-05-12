
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = (((x & Cin) | (x & Cin)) | (x & y)) | (y & (((x & y) | (x & (y & Cin))) | Cin));
  assign s = (((((~x & y) | (Cin & ~y)) & ~x) & (((~y & (~Cin | ~x)) | ~Cin) | ((((Cin & ~x) | (x & (y & Cin))) & ~y) | (x & (y & Cin))))) | (x & (~y & ~Cin))) | ((((x & (~y & ~Cin)) | (x & Cin)) & y) | (x & (~y & ~Cin)));
endmodule

