
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w16,w17,w544,w545,w4360,w4905,w16384,w11479;

  assign w1 = i_data0;
  assign w11479 = w16384-w4905;
  assign w16 = w1*((1+1)**4);
  assign w16384 = ((1+1)**14)*w1;
  assign w17 = w16+w1;
  assign w4360 = w545<<3;
  assign w4905 = w545+w4360;
  assign w544 = ((1+1)**5)*w17;
  assign w545 = w544+w1;
  assign o_data0 = w11479;
endmodule

