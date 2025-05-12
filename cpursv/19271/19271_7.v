
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w64,w65,w16384,w16319,w1040,w15279,w512,w14767;

  assign w1 = i_data0;
  assign w1040 = (1<<<1**4)*w65;
  assign w14767 = w15279-w512;
  assign w15279 = w16319-w1040;
  assign w16319 = w16384-w65;
  assign w16384 = w1*(1<<<1**14);
  assign w512 = w1<<9;
  assign w64 = w1<<6;
  assign w65 = w1+w64;
  assign o_data0 = w14767;
endmodule

