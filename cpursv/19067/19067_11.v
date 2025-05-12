
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1;
  wire [31:0] w512;
  wire [31:0] w511;
  wire [31:0] w2044;
  wire [31:0] w2045;
  wire [31:0] w16;
  wire [31:0] w2061;
  wire [31:0] w8244;
  wire [31:0] w7733;

  assign w1 = i_data0;
  assign w16 = w1<<4;
  assign w2044 = (1<<1+1<<1)*w511;
  assign w2045 = w1+w2044;
  assign w2061 = w2045+w16;
  assign w511 = w512-w1;
  assign w512 = w1<<<9;
  assign w7733 = w8244-w511;
  assign w8244 = 1<<1*(w2061*1<<1);
  assign o_data0 = w7733;
endmodule

