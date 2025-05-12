
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w4,w5,w320,w319,w1276;

  assign w1 = i_data0;
  assign w1276 = 1<<<1<<1*w319;
  assign w319 = w320-w1;
  assign w320 = (1<<1**6)*w5;
  assign w4 = w1*1<<<1<<1;
  assign w5 = w1+w4;
  assign o_data0 = w1276;
endmodule

