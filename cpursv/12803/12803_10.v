
module spiral_0(i_data,o_data_36,o_data_83);

  input  signed  [19:0] i_data;
  output signed  [7+19:0] o_data_36;
  output signed  [7+19:0] o_data_83;
  wire signed  [26:0] w1,w8,w9,w64,w65,w18,w83,w36;

  assign w1 = i_data;
  assign w8 = w1<<3;
  assign w9 = w8+w1;
  assign w64 = w1<<<6;
  assign w65 = w1+w64;
  assign w18 = 2*w9;
  assign w83 = w18+w65;
  assign w36 = (2**2)*w9;
  assign o_data_36 = w36;
  assign o_data_83 = w83;
endmodule

