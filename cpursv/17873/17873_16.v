
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w2048,w2049,w8196,w6147,w64,w6211,w24844;

  assign w1 = i_data0;
  assign w2048 = ((1+1)**11)*w1;
  assign w2049 = w1+w2048;
  assign w24844 = w6211<<1*(1+1);
  assign w6147 = w8196+(0-w2049);
  assign w6211 = w64+w6147;
  assign w64 = w1<<6;
  assign w8196 = w2049*1<<(1+1);
  assign o_data0 = w24844;
endmodule

