
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
  assign w129 = w1+w128;
  assign w23217 = (-w7739)+w30956;
  assign w30956 = w7739*1<<1<<1;
  assign w516 = w129<<<1<<1;
  assign w64 = w1<<<6;
  assign w7739 = (0-w516)+w8255;
  assign w8191 = w8192+(-w1);
  assign w8192 = w1<<13;
  assign w8255 = w64+w8191;
  assign o_data0 = w23217;
endmodule

