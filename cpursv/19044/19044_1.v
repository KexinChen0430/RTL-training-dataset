
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w512,w511,w8176,w8175,w7663,w15326;

  assign w1 = i_data0;
  assign w15326 = 1<<<1*w7663;
  assign w511 = w512+(-w1);
  assign w512 = w1<<<9;
  assign w7663 = (0-w512)+w8175;
  assign w8175 = (-w1)+w8176;
  assign w8176 = w511<<4;
  assign o_data0 = w15326;
endmodule

