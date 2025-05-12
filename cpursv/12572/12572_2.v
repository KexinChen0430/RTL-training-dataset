
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((Cin & x) | y) & ((y & Cin) | x);
  assign s = (((x & (y & Cin)) | (((~y & Cin) | (x & (y & Cin))) & ~x)) | ((~y & ~Cin) & x)) | ((y & ~x) & ~Cin);
endmodule

