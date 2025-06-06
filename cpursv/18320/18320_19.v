
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w512,w513,w64,w449,w7184,w7633,w15266;

  assign w1 = i_data0;
  assign w15266 = 2*w7633;
  assign w449 = w513+(-w64);
  assign w512 = (2**9)*w1;
  assign w513 = w1+w512;
  assign w64 = w1<<<6;
  assign w7184 = w449*(2**4);
  assign w7633 = w7184+w449;
  assign o_data0 = w15266;
endmodule

