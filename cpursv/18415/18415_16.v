
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w16,w17,w4,w13,w6656,w6643,w16384,w23027;

  assign w1 = i_data0;
  assign w13 = w17-w4;
  assign w16 = w1<<4;
  assign w16384 = (1<<<1**14)*w1;
  assign w17 = w16+w1;
  assign w23027 = w16384+w6643;
  assign w4 = 1<<<1<<1*w1;
  assign w6643 = w6656-w13;
  assign w6656 = w13<<<9;
  assign o_data0 = w23027;
endmodule

