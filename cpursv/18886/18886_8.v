
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w128  ,
      w129  ,
      w2064 ,
      w2193 ,
      w516  ,
      w2709 ,
      w8    ,
      w2701 ,
      w21608;

  assign w1 = i_data0;
  assign w128 = w1<<<7;
  assign w129 = w128+w1;
  assign w2064 = w129<<4;
  assign w21608 = w2701<<3;
  assign w2193 = w2064+w129;
  assign w2701 = (-w8)+w2709;
  assign w2709 = w516+w2193;
  assign w516 = 1<<1<<1*w129;
  assign w8 = w1*(1<<1**3);
  assign o_data0 = w21608;
endmodule

