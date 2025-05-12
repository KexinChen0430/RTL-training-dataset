
module decoder_74138_dataflow(input  [0:2] x,
                              input  g1,
                              input  g2a_n,
                              input  g2b_n,
                              output [7:0] y);

  assign y[0] = ((g2b_n | g2a_n) | x[0]) | ((~g1 | x[2]) | x[1]);
  assign y[1] = ((g2b_n | g2a_n) | x[0]) | (~g1 | (x[1] | ~x[2]));
  assign y[2] = ((g2a_n | ~x[1]) | x[2]) | (x[0] | (~g1 | g2b_n));
  assign y[3] = (~x[2] | g2a_n) | (~x[1] | (x[0] | (~g1 | g2b_n)));
  assign y[4] = (x[1] | ~x[0]) | ((g2b_n | g2a_n) | (~g1 | x[2]));
  assign y[5] = (x[1] | ((~g1 | ~x[0]) | ~x[2])) | (g2b_n | g2a_n);
  assign y[6] = (x[2] | g2b_n) | ((~g1 | ~x[0]) | (g2a_n | ~x[1]));
  assign y[7] = (~g1 | ~x[2]) | ((g2a_n | (~x[1] | ~x[0])) | g2b_n);
endmodule

