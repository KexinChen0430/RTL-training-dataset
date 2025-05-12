
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w4096,w4095,w256,w4351,w32,w4383,w2,w4381,w8762;

  assign w1 = i_data0;
  assign w2 = w1<<<1;
  assign w256 = 1<<<8*w1;
  assign w32 = w1<<<5;
  assign w4095 = w4096-w1;
  assign w4096 = w1*1<<<12;
  assign w4351 = w256+w4095;
  assign w4381 = w4383+(0-w2);
  assign w4383 = w32+w4351;
  assign w8762 = w4381*2;
  assign o_data0 = w8762;
endmodule

