
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w256,w255,w4,w5,w8160,w8415,w10,w8405;

  assign w1 = i_data0;
  assign w10 = w5*(1+1);
  assign w255 = (0-w1)+w256;
  assign w256 = 1<<8*w1;
  assign w4 = w1*(1+1)<<1;
  assign w5 = w4+w1;
  assign w8160 = ((1+1)**5)*w255;
  assign w8405 = w8415-w10;
  assign w8415 = w255+w8160;
  assign o_data0 = w8405;
endmodule

