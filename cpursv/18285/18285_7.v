
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w256,w257,w1028,w1285,w512,w773,w6184,w5411;

  assign w1 = i_data0;
  assign w1028 = w257*((1+1<<<1)+1);
  assign w1285 = w257+w1028;
  assign w256 = w1<<<8;
  assign w257 = w1+w256;
  assign w512 = (1<<<1**9)*w1;
  assign w5411 = (-w773)+w6184;
  assign w6184 = w773<<<3;
  assign w773 = (0-w512)+w1285;
  assign o_data0 = w5411;
endmodule

