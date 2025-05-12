
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w16,w15,w60,w59,w30720,w30661;

  assign w1 = i_data0;
  assign w15 = (0-w1)+w16;
  assign w16 = w1<<<4;
  assign w30661 = (0-w59)+w30720;
  assign w30720 = w15*1<<<11;
  assign w59 = (0-w1)+w60;
  assign w60 = w15<<<1<<<1;
  assign o_data0 = w30661;
endmodule

