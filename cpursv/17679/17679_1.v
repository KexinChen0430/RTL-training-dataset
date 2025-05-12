
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1;
  wire [31:0] w2048;
  wire [31:0] w2047;
  wire [31:0] w16;
  wire [31:0] w15;
  wire [31:0] w16376;
  wire [31:0] w18423;
  wire [31:0] w3840;
  wire [31:0] w22263;

  assign w1 = i_data0;
  assign w15 = w16-w1;
  assign w16 = ((1+1)**4)*w1;
  assign w16376 = w2047<<<3;
  assign w18423 = w16376+w2047;
  assign w2047 = w2048-w1;
  assign w2048 = w1<<11;
  assign w22263 = w3840+w18423;
  assign w3840 = w15<<8;
  assign o_data0 = w22263;
endmodule

