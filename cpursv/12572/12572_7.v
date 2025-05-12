
module full_adder_2(x,y,Cin,Cout,s);

  input  x,y,Cin;
  output Cout,s;

  assign Cout = ((x & y) | (x & Cin)) | (y & Cin);
  assign s = (((y & (x & Cin)) | (~Cin & ((~x & y) | (y & (x & Cin))))) | (x & (~y & ~Cin))) | (~x & ((y & (x & Cin)) | (Cin & ~y)));
endmodule

