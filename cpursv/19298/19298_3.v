
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w8192,w8193,w16386,w16387,w2048,w14339;

  assign w1 = i_data0;
  assign w14339 = w16387+(-w2048);
  assign w16386 = 2*w8193;
  assign w16387 = w16386+w1;
  assign w2048 = w1<<11;
  assign w8192 = (2**13)*w1;
  assign w8193 = w8192+w1;
  assign o_data0 = w14339;
endmodule

