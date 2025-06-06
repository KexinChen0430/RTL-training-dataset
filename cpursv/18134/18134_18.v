
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w4,w5,w8192,w8187,w160,w8027,w16054;

  assign w1 = i_data0;
  assign w160 = w5*(1<<<1**5);
  assign w16054 = w8027<<<1;
  assign w4 = w1<<1<<<1;
  assign w5 = w4+w1;
  assign w8027 = (-w160)+w8187;
  assign w8187 = (-w5)+w8192;
  assign w8192 = w1*1<<<13;
  assign o_data0 = w16054;
endmodule

