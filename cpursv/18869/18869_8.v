
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
  assign w12517 = w8453+w4064;
  assign w127 = w128-w1;
  assign w128 = (1<<<1**7)*w1;
  assign w256 = (1<<<1**8)*w1;
  assign w4 = 1<<<1<<1*w1;
  assign w4064 = w127<<<5;
  assign w8192 = w1<<13;
  assign w8193 = w1+w8192;
  assign w8197 = w8193+w4;
  assign w8453 = w256+w8197;
  assign o_data0 = w12517;
endmodule

