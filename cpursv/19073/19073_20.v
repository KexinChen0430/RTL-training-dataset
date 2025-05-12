
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w32,w33,w4096,w4129,w264,w4393,w1024,w3369;

  assign w1 = i_data0;
  assign w1024 = w1*(1<<<1**10);
  assign w264 = w33*(1<<<1**3);
  assign w32 = (1<<<1**5)*w1;
  assign w33 = w32+w1;
  assign w3369 = w4393-w1024;
  assign w4096 = (1<<<1**12)*w1;
  assign w4129 = w33+w4096;
  assign w4393 = w264+w4129;
  assign o_data0 = w3369;
endmodule

