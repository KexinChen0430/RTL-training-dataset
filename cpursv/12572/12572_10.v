
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = (((y & x) | (y & Cin)) | Cin) & (y | (x & Cin));
  assign s = (((~Cin & (y & ~x)) | (x & (~Cin & ~y))) | (x & (y & Cin))) | (~x & (((x & (y & Cin)) | (~y & Cin)) | (((~Cin & y) | (x & (y & Cin))) & ~x)));
endmodule

