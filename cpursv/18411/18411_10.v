
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w128,w129,w4096,w4225,w1032,w3193,w32,w3161;

  assign w1 = i_data0;
  assign w1032 = (2**3)*w129;
  assign w128 = (2**7)*w1;
  assign w129 = w128+w1;
  assign w3161 = (0-w32)+w3193;
  assign w3193 = (0-w1032)+w4225;
  assign w32 = (2**5)*w1;
  assign w4096 = w1<<<12;
  assign w4225 = w129+w4096;
  assign o_data0 = w3161;
endmodule

