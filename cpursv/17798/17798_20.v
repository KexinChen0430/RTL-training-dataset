
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1;
  wire [31:0] w4;
  wire [31:0] w3;
  wire [31:0] w48;
  wire [31:0] w51;
  wire [31:0] w1632;
  wire [31:0] w1683;
  wire [31:0] w13464;

  assign w1 = i_data0;
  assign w13464 = w1683<<3;
  assign w1632 = (1<<<1**5)*w51;
  assign w1683 = w51+w1632;
  assign w3 = (-w1)+w4;
  assign w4 = (1<<<1*1<<<1)*w1;
  assign w48 = w3<<4;
  assign w51 = w3+w48;
  assign o_data0 = w13464;
endmodule

