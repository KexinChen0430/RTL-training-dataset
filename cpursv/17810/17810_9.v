
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w256,w257,w8224,w8225,w16,w241,w964,w7261;

  assign w1 = i_data0;
  assign w16 = w1<<4;
  assign w241 = w257+(-w16);
  assign w256 = ((1+1)**8)*w1;
  assign w257 = w256+w1;
  assign w7261 = (-w964)+w8225;
  assign w8224 = ((1+1)**5)*w257;
  assign w8225 = w1+w8224;
  assign w964 = (1+1)*w241<<1;
  assign o_data0 = w7261;
endmodule

