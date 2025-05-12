
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
  assign w10236 = w2559*2<<<1;
  assign w2048 = w1<<<11;
  assign w2559 = w511+w2048;
  assign w30708 = w7677<<2;
  assign w511 = (0-w1)+w512;
  assign w512 = w1*(2**9);
  assign w7677 = w10236-w2559;
  assign o_data0 = w30708;
endmodule

