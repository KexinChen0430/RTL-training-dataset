
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] w1,w256,w257,w128,w385,w1028,w643,w12320,w12963;

  assign w1 = i_data0;
  assign w1028 = (1+(1<<1+1))*w257;
  assign w12320 = w385*(1<<1**5);
  assign w128 = w1<<7;
  assign w12963 = w12320+w643;
  assign w256 = (1<<1**8)*w1;
  assign w257 = w256+w1;
  assign w385 = w128+w257;
  assign w643 = w1028+(0-w385);
  assign o_data0 = w12963;
endmodule

