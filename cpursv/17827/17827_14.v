
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w4096 ,
      w4095 ,
      w256  ,
      w3839 ,
      w15356,
      w11517,
      w16   ,
      w11533,
      w128  ,
      w11405;

  assign w1 = i_data0;
  assign w11405 = (-w128)+w11533;
  assign w11517 = (0-w3839)+w15356;
  assign w11533 = w11517+w16;
  assign w128 = ((1+1)**7)*w1;
  assign w15356 = w3839*(1+(1+(1+1)));
  assign w16 = w1<<<4;
  assign w256 = ((1+1)**8)*w1;
  assign w3839 = (-w256)+w4095;
  assign w4095 = w4096-w1;
  assign w4096 = w1<<12;
  assign o_data0 = w11405;
endmodule

