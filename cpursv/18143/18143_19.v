
module c(c_in,d_in,out1);

  input  c_in;
  input  d_in;
  output out1;
  wire out1;
  wire temp;

  assign out1 = d_in ^ ((temp & (d_in | ~d_in)) & (~temp | temp));
  assign temp = d_in & c_in;
endmodule

