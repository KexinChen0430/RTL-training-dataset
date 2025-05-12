
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w64,w63,w4096,w4097,w4161,w504,w3657,w14628;

  assign w1 = i_data0;
  assign w14628 = 2*w3657<<1;
  assign w3657 = (0-w504)+w4161;
  assign w4096 = w1*(2**12);
  assign w4097 = w1+w4096;
  assign w4161 = w64+w4097;
  assign w504 = w63<<3;
  assign w63 = w64+(0-w1);
  assign w64 = w1*(2**6);
  assign o_data0 = w14628;
endmodule

