
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w256  ,
      w257  ,
      w16384,
      w16127,
      w1028 ,
      w15099,
      w512  ,
      w14587,
      w29174;

  assign w1 = i_data0;
  assign w1028 = (w257*1<<<1)*1<<<1;
  assign w14587 = (0-w512)+w15099;
  assign w15099 = (-w1028)+w16127;
  assign w16127 = (-w257)+w16384;
  assign w16384 = w1<<<14;
  assign w256 = w1<<8;
  assign w257 = w1+w256;
  assign w29174 = w14587*1<<<1;
  assign w512 = w1<<9;
  assign o_data0 = w29174;
endmodule

