
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w64,w63,w252,w315,w256,w257,w4112,w4427;

  assign w1 = i_data0;
  assign w252 = w63<<<1<<1;
  assign w256 = (1<<1**8)*w1;
  assign w257 = w256+w1;
  assign w315 = w252+w63;
  assign w4112 = w257<<<4;
  assign w4427 = w4112+w315;
  assign w63 = w64+(-w1);
  assign w64 = w1*(1<<1**6);
  assign o_data0 = w4427;
endmodule

