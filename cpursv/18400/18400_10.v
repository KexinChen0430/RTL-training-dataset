
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w256  ,
      w255  ,
      w2040 ,
      w2295 ,
      w2    ,
      w2297 ,
      w9188 ,
      w6891 ,
      w27564;

  assign w1 = i_data0;
  assign w2 = w1*1<<1;
  assign w2040 = w255<<<3;
  assign w2295 = w2040+w255;
  assign w2297 = w2295+w2;
  assign w255 = (0-w1)+w256;
  assign w256 = w1<<8;
  assign w27564 = 1<<1<<1*w6891;
  assign w6891 = (0-w2297)+w9188;
  assign w9188 = (w2297*1<<1)*1<<1;
  assign o_data0 = w27564;
endmodule

