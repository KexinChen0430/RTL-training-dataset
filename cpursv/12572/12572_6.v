
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((y & x) | ((((((x & Cin) | (x & Cin)) | (y & x)) | ((x | Cin) & y)) | Cin) & y)) | (((x & Cin) | (x & Cin)) | (y & x));
  assign s = ((((((x & Cin) & y) | ((~y & x) & ~Cin)) | (x & Cin)) | Cin) & (((y & x) | ((~Cin & y) & ~x)) | ((~y & (~x & Cin)) | ((~y & x) & ~Cin)))) | ((~y & (~x & Cin)) | (((~y & (~x & Cin)) | (~x & ~Cin)) & y));
endmodule

