
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w64,w63,w4096,w4097,w4161,w504,w3657,w14628;

  assign w1 = i_data0;
  assign w14628 = w3657<<1<<1;
  assign w3657 = w4161+(-w504);
  assign w4096 = w1<<12;
  assign w4097 = w4096+w1;
  assign w4161 = w64+w4097;
  assign w504 = ((1+1)**3)*w63;
  assign w63 = (-w1)+w64;
  assign w64 = w1<<<6;
  assign o_data0 = w14628;
endmodule

