
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w512,w511,w4,w5,w10,w501,w2004,w1493,w11944;

  assign w1 = i_data0;
  assign w10 = 1<<1*w5;
  assign w11944 = w1493<<3;
  assign w1493 = w2004+(0-w511);
  assign w2004 = 1<<1*w501<<<1;
  assign w4 = w1<<1<<1;
  assign w5 = w4+w1;
  assign w501 = w511+(-w10);
  assign w511 = w512+(-w1);
  assign w512 = w1<<9;
  assign o_data0 = w11944;
endmodule

