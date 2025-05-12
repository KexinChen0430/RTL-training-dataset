
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w2048,w2049,w16,w2033,w512,w1521,w12168,w13689;

  assign w1 = i_data0;
  assign w12168 = w1521*(1<<<1**3);
  assign w13689 = w1521+w12168;
  assign w1521 = w2033-w512;
  assign w16 = (1<<<1**4)*w1;
  assign w2033 = (-w16)+w2049;
  assign w2048 = (1<<<1**11)*w1;
  assign w2049 = w1+w2048;
  assign w512 = w1<<9;
  assign o_data0 = w13689;
endmodule

