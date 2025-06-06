
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w4096 ,
      w4095 ,
      w256  ,
      w4351 ,
      w1024 ,
      w5375 ,
      w21500,
      w26875;

  assign w1 = i_data0;
  assign w1024 = w1<<10;
  assign w21500 = w5375<<1<<1;
  assign w256 = w1<<<8;
  assign w26875 = w21500+w5375;
  assign w4095 = w4096-w1;
  assign w4096 = w1<<<12;
  assign w4351 = w256+w4095;
  assign w5375 = w4351+w1024;
  assign o_data0 = w26875;
endmodule

