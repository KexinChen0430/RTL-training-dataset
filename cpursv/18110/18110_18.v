
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w64,w65,w16,w49,w16640,w16591,w6272,w22863;

  assign w1 = i_data0;
  assign w16 = w1<<<4;
  assign w16591 = w16640-w49;
  assign w16640 = w65<<<8;
  assign w22863 = w6272+w16591;
  assign w49 = w65+(-w16);
  assign w6272 = w49<<7;
  assign w64 = w1<<6;
  assign w65 = w64+w1;
  assign o_data0 = w22863;
endmodule

