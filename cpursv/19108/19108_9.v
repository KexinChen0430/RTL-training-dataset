
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w2048 ,
      w2049 ,
      w64   ,
      w1985 ,
      w15880,
      w17865,
      w4098 ,
      w21963,
      w8    ,
      w21955;

  assign w1 = i_data0;
  assign w15880 = w1985*(1<<1**3);
  assign w17865 = w1985+w15880;
  assign w1985 = (-w64)+w2049;
  assign w2048 = (1<<1**11)*w1;
  assign w2049 = w2048+w1;
  assign w21955 = w21963-w8;
  assign w21963 = w17865+w4098;
  assign w4098 = w2049*1<<1;
  assign w64 = w1<<<6;
  assign w8 = w1<<3;
  assign o_data0 = w21955;
endmodule

