
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w64,w63,w8192,w8129,w32,w95,w1520,w6609,w26436;

  assign w1 = i_data0;
  assign w1520 = w95<<4;
  assign w26436 = ((1+1<<1)+1)*w6609;
  assign w32 = w1<<<5;
  assign w63 = (-w1)+w64;
  assign w64 = (1<<1**6)*w1;
  assign w6609 = w8129+(0-w1520);
  assign w8129 = w8192+(-w63);
  assign w8192 = w1*(1<<1**13);
  assign w95 = w63+w32;
  assign o_data0 = w26436;
endmodule

