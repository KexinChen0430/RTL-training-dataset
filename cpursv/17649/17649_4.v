
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w64,w65,w4160,w4159,w260,w325,w650,w3509,w7018;

  assign w1 = i_data0;
  assign w260 = 1<<<1*w65<<<1;
  assign w325 = w260+w65;
  assign w3509 = (0-w650)+w4159;
  assign w4159 = w4160+(-w1);
  assign w4160 = w65*(1<<<1**6);
  assign w64 = w1<<6;
  assign w65 = w1+w64;
  assign w650 = 1<<<1*w325;
  assign w7018 = w3509<<1;
  assign o_data0 = w7018;
endmodule

