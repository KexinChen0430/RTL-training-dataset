
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w8192 ,
      w8193 ,
      w4    ,
      w8197 ,
      w256  ,
      w8453 ,
      w128  ,
      w127  ,
      w4064 ,
      w12517;

  assign w1 = i_data0;
  assign w12517 = w4064+w8453;
  assign w127 = w128+(-w1);
  assign w128 = w1<<<7;
  assign w256 = w1*((1+1)**8);
  assign w4 = (1+1)*w1<<<1;
  assign w4064 = ((1+1)**5)*w127;
  assign w8192 = 1<<13*w1;
  assign w8193 = w8192+w1;
  assign w8197 = w8193+w4;
  assign w8453 = w8197+w256;
  assign o_data0 = w12517;
endmodule

