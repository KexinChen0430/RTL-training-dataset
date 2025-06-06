
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1;
  wire [31:0] w512;
  wire [31:0] w511;
  wire [31:0] w2048;
  wire [31:0] w2559;
  wire [31:0] w10236;
  wire [31:0] w7677;
  wire [31:0] w30708;

  assign w1 = i_data0;
  assign w10236 = 1<<<1<<<1*w2559;
  assign w2048 = (1<<<1**11)*w1;
  assign w2559 = w2048+w511;
  assign w30708 = 1<<<1<<<1*w7677;
  assign w511 = w512-w1;
  assign w512 = w1<<<9;
  assign w7677 = (-w2559)+w10236;
  assign o_data0 = w30708;
endmodule

