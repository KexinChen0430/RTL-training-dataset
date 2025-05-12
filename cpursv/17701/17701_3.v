
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w4,w5,w4096,w4101,w160,w4261,w17044,w17043;

  assign w1 = i_data0;
  assign w160 = (1<<1**5)*w5;
  assign w17043 = w17044+(0-w1);
  assign w17044 = w4261<<<1<<1;
  assign w4 = (1<<1+1<<1)*w1;
  assign w4096 = w1<<<12;
  assign w4101 = w5+w4096;
  assign w4261 = w4101+w160;
  assign w5 = w1+w4;
  assign o_data0 = w17043;
endmodule

