
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
  assign w128 = (1<<1**7)*w1;
  assign w129 = w128+w1;
  assign w23217 = w30956-w7739;
  assign w30956 = 1<<1<<1*w7739;
  assign w516 = (w129*1<<1)*1<<1;
  assign w64 = (1<<1**6)*w1;
  assign w7739 = (0-w516)+w8255;
  assign w8191 = w8192+(-w1);
  assign w8192 = (1<<1**13)*w1;
  assign w8255 = w8191+w64;
  assign o_data0 = w23217;
endmodule

