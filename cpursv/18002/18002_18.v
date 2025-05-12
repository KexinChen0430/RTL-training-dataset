
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w4,w5,w2048,w2047,w640,w2687,w10,w2677;

  assign w1 = i_data0;
  assign w10 = w5*(1+1);
  assign w2047 = w2048-w1;
  assign w2048 = w1<<11;
  assign w2677 = w2687-w10;
  assign w2687 = w640+w2047;
  assign w4 = w1*(1+1)<<1;
  assign w5 = w4+w1;
  assign w640 = ((1+1)**7)*w5;
  assign o_data0 = w2677;
endmodule

