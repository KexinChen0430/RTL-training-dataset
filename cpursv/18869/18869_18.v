
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
  assign w127 = w128+(-w1);
  assign w128 = w1*1<<<7;
  assign w256 = w1<<8;
  assign w4 = w1<<<1<<<1;
  assign w4064 = w127<<5;
  assign w8192 = w1<<13;
  assign w8193 = w8192+w1;
  assign w8197 = w4+w8193;
  assign w8453 = w8197+w256;
  assign o_data0 = w12517;
endmodule

