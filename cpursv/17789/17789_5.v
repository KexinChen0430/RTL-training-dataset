
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w4,w3,w48,w45,w5760,w5759;

  assign w1 = i_data0;
  assign w4 = w1<<<1<<1;
  assign w3 = w4-w1;
  assign w48 = w3*(1<<1**4);
  assign w45 = w48+(0-w3);
  assign w5760 = w45<<<7;
  assign w5759 = w5760-w1;
  assign o_data0 = w5759;
endmodule

