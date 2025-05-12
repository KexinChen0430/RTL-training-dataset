
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w2048 ,
      w2049 ,
      w128  ,
      w1921 ,
      w16   ,
      w1937 ,
      w4    ,
      w1941 ,
      w31056;

  assign w1 = i_data0;
  assign w128 = 1<<7*w1;
  assign w16 = w1*1<<<4;
  assign w1921 = w2049+(0-w128);
  assign w1937 = w16+w1921;
  assign w1941 = w4+w1937;
  assign w2048 = w1<<11;
  assign w2049 = w1+w2048;
  assign w31056 = w1941*1<<<4;
  assign w4 = w1<<<1*(1+1);
  assign o_data0 = w31056;
endmodule

