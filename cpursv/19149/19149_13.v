
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w1024,w1023,w64,w63,w8064,w9087,w4092,w13179;

  assign w1 = i_data0;
  assign w1024 = w1*((1+1)**10);
  assign w1023 = w1024+(-w1);
  assign w64 = w1*((1+1)**6);
  assign w63 = w64+(-w1);
  assign w8064 = ((1+1)**7)*w63;
  assign w9087 = w1023+w8064;
  assign w4092 = w1023<<<1<<1;
  assign w13179 = w9087+w4092;
  assign o_data0 = w13179;
endmodule

