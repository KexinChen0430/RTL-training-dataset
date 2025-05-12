
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w8192 ,
      w8191 ,
      w64   ,
      w8255 ,
      w128  ,
      w129  ,
      w516  ,
      w7739 ,
      w30956,
      w23217;

  assign w1 = i_data0;
  assign w128 = w1*(1<<1**7);
  assign w129 = w128+w1;
  assign w23217 = (-w7739)+w30956;
  assign w30956 = w7739<<<1<<1;
  assign w516 = 1<<<1<<1*w129;
  assign w64 = w1*(1<<1**6);
  assign w7739 = w8255-w516;
  assign w8191 = w8192-w1;
  assign w8192 = w1<<<13;
  assign w8255 = w8191+w64;
  assign o_data0 = w23217;
endmodule

