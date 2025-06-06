
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w512,w513,w4,w517,w8272,w8789;

  assign w1 = i_data0;
  assign w4 = w1<<<2;
  assign w512 = (2**9)*w1;
  assign w513 = w512+w1;
  assign w517 = w513+w4;
  assign w8272 = (2**4)*w517;
  assign w8789 = w517+w8272;
  assign o_data0 = w8789;
endmodule

