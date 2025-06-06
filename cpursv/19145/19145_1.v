
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w16,w17,w544,w545,w4360,w4905,w16384,w11479;

  assign w1 = i_data0;
  assign w11479 = (-w4905)+w16384;
  assign w16 = w1*(2**4);
  assign w16384 = (2**14)*w1;
  assign w17 = w1+w16;
  assign w4360 = w545<<3;
  assign w4905 = w4360+w545;
  assign w544 = (2**5)*w17;
  assign w545 = w1+w544;
  assign o_data0 = w11479;
endmodule

