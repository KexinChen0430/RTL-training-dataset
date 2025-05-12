
module c(c_in,d_in,out1);

  input  c_in;
  input  d_in;
  output out1;
  wire out1;
  wire temp;

  assign out1 = ((d_in ^ (d_in & ((~d_in | d_in) & temp))) & ~temp) | (((~(((~d_in | d_in) & temp) & ~d_in) & (d_in & ~d_in)) | ~(d_in & ~d_in)) & ((~(((~d_in | d_in) & temp) & ~d_in) & (d_in & ~d_in)) | (((~d_in | d_in) & temp) & ~d_in)));
  assign temp = c_in & d_in;
endmodule

