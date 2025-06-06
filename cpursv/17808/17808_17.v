
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w512,w511,w128,w129,w1022,w893,w7144;

  assign w1 = i_data0;
  assign w1022 = (1+1)*w511;
  assign w128 = w1<<7;
  assign w129 = w128+w1;
  assign w511 = w512+(-w1);
  assign w512 = w1*((1+1)**9);
  assign w7144 = w893<<<3;
  assign w893 = w1022+(0-w129);
  assign o_data0 = w7144;
endmodule

