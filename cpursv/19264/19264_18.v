
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w16384,w16383,w32,w16351,w8,w9,w1152,w15199;

  assign w1 = i_data0;
  assign w1152 = w9*(1<<1**7);
  assign w15199 = w16351+(-w1152);
  assign w16351 = w16383+(-w32);
  assign w16383 = w16384-w1;
  assign w16384 = w1*(1<<1**14);
  assign w32 = w1<<<5;
  assign w8 = w1<<<3;
  assign w9 = w8+w1;
  assign o_data0 = w15199;
endmodule

