
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w256,w255,w16,w239,w3824,w3569,w7138;

  assign w1 = i_data0;
  assign w16 = (1<<<1**4)*w1;
  assign w239 = w255-w16;
  assign w255 = w256-w1;
  assign w256 = w1<<<8;
  assign w3569 = w3824-w255;
  assign w3824 = w239*(1<<<1**4);
  assign w7138 = 1<<<1*w3569;
  assign o_data0 = w7138;
endmodule

