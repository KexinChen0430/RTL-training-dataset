
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w1024,w1023,w8,w9,w144,w1167,w4668,w3501,w7002;

  assign w1 = i_data0;
  assign w1023 = w1024-w1;
  assign w1024 = w1*((1+1)**10);
  assign w1167 = w144+w1023;
  assign w144 = ((1+1)**4)*w9;
  assign w3501 = (-w1167)+w4668;
  assign w4668 = w1167<<<1+1;
  assign w7002 = (1+1)*w3501;
  assign w8 = w1*((1+1)**3);
  assign w9 = w8+w1;
  assign o_data0 = w7002;
endmodule

