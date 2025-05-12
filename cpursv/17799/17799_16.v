
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w128,w127,w256,w257,w64,w321,w2032,w1711;

  assign w1 = i_data0;
  assign w127 = (0-w1)+w128;
  assign w128 = w1<<<7;
  assign w1711 = w2032-w321;
  assign w2032 = (2**4)*w127;
  assign w256 = (2**8)*w1;
  assign w257 = w1+w256;
  assign w321 = w257+w64;
  assign w64 = w1*(2**6);
  assign o_data0 = w1711;
endmodule

