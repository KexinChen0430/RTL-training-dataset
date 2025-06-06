
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w128,w127,w2032,w2159,w2,w2161,w17288,w15127;

  assign w1 = i_data0;
  assign w127 = w128-w1;
  assign w128 = 1<<7*w1;
  assign w15127 = (0-w2161)+w17288;
  assign w17288 = w2161<<3;
  assign w2 = w1<<1;
  assign w2032 = w127*(1<<1**4);
  assign w2159 = w2032+w127;
  assign w2161 = w2+w2159;
  assign o_data0 = w15127;
endmodule

