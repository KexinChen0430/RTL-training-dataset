
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w128,w129,w16512,w16511,w32,w16479;

  assign w1 = i_data0;
  assign w128 = (1<<1**7)*w1;
  assign w129 = w128+w1;
  assign w16512 = w129<<7;
  assign w16511 = (-w1)+w16512;
  assign w32 = w1*(1<<1**5);
  assign w16479 = (-w32)+w16511;
  assign o_data0 = w16479;
endmodule

