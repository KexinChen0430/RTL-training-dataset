
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w16,w17,w2176,w2193,w1024,w3217,w25736,w25753;

  assign w1 = i_data0;
  assign w1024 = w1<<10;
  assign w16 = (2**4)*w1;
  assign w17 = w1+w16;
  assign w2176 = (2**7)*w17;
  assign w2193 = w17+w2176;
  assign w25736 = w3217<<3;
  assign w25753 = w17+w25736;
  assign w3217 = w1024+w2193;
  assign o_data0 = w25753;
endmodule

