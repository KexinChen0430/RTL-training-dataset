
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w8,w7,w56,w55,w1760,w1753;

  assign w1 = i_data0;
  assign w1753 = (0-w7)+w1760;
  assign w1760 = (1<<<1**5)*w55;
  assign w55 = w56+(0-w1);
  assign w56 = w7<<3;
  assign w7 = w8+(0-w1);
  assign w8 = (1<<<1**3)*w1;
  assign o_data0 = w1753;
endmodule

