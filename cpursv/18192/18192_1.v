
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w8,w7,w8192,w8185,w896,w7289,w1792,w5497,w10994;

  assign w1 = i_data0;
  assign w10994 = w5497*1<<1;
  assign w1792 = w7*(1<<1**8);
  assign w5497 = (0-w1792)+w7289;
  assign w7 = w8-w1;
  assign w7289 = w8185+(-w896);
  assign w8 = w1<<<3;
  assign w8185 = w8192-w7;
  assign w8192 = w1*(1<<1**13);
  assign w896 = w7<<<7;
  assign o_data0 = w10994;
endmodule

