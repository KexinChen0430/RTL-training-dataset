
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w128,w129,w4,w133,w2064,w1931,w30896;

  assign w1 = i_data0;
  assign w128 = w1<<<7;
  assign w129 = w128+w1;
  assign w133 = w129+w4;
  assign w1931 = (-w133)+w2064;
  assign w2064 = ((1+1)**4)*w129;
  assign w30896 = w1931<<<4;
  assign w4 = w1<<<1+1;
  assign o_data0 = w30896;
endmodule

