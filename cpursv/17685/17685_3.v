
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w32   ,
      w31   ,
      w8192 ,
      w8193 ,
      w496  ,
      w8689 ,
      w3968 ,
      w4721 ,
      w18884;

  assign w1 = i_data0;
  assign w18884 = w4721<<<1<<1;
  assign w31 = (-w1)+w32;
  assign w32 = (1<<1**5)*w1;
  assign w3968 = w31*(1<<1**7);
  assign w4721 = (0-w3968)+w8689;
  assign w496 = (1<<1**4)*w31;
  assign w8192 = w1<<<13;
  assign w8193 = w8192+w1;
  assign w8689 = w496+w8193;
  assign o_data0 = w18884;
endmodule

