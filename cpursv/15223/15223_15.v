
module decoder_74138_dataflow(input  [2:0] x,
                              input  g1,g2a_n,g2b_n,
                              output [7:0] y);

  assign y[0] = ((x[0] | ~g1) | x[1]) | ((g2a_n | g2b_n) | x[2]);
  assign y[1] = ((~g1 | (~x[2] | g2b_n)) | (x[0] | g2a_n)) | x[1];
  assign y[2] = (x[2] | (~x[1] | g2b_n)) | ((g2a_n | ~g1) | x[0]);
  assign y[3] = (g2a_n | ~g1) | (((~x[2] | g2b_n) | ~x[1]) | x[0]);
  assign y[4] = (((g2a_n | ~g1) | x[1]) | x[2]) | (~x[0] | g2b_n);
  assign y[5] = (~g1 | (x[1] | ~x[2])) | (g2b_n | (g2a_n | ~x[0]));
  assign y[6] = (~x[0] | ~g1) | ((x[2] | (~x[1] | g2b_n)) | g2a_n);
  assign y[7] = ((g2b_n | (g2a_n | ~x[0])) | ~x[2]) | (~x[1] | ~g1);
endmodule

