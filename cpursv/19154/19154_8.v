
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w64,w63,w8064,w8001,w16,w8017,w32068;

  assign w1 = i_data0;
  assign w16 = w1<<4;
  assign w32068 = w8017<<1<<<1;
  assign w63 = w64+(-w1);
  assign w64 = w1<<<6;
  assign w8001 = w8064-w63;
  assign w8017 = w16+w8001;
  assign w8064 = w63*(1<<<1**7);
  assign o_data0 = w32068;
endmodule

