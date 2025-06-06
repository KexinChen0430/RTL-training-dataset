
module multiplier_block(i_data0,o_data0);

  input  [31:0] i_data0;
  output [31:0] o_data0;
  wire [31:0] 
      w1    ,
      w8    ,
      w7    ,
      w14336,
      w14329,
      w32   ,
      w14297,
      w112  ,
      w14185,
      w28370;

  assign w1 = i_data0;
  assign w112 = w7<<4;
  assign w14185 = w14297+(-w112);
  assign w14297 = w14329-w32;
  assign w14329 = w14336-w7;
  assign w14336 = w7<<11;
  assign w28370 = 1<<<1*w14185;
  assign w32 = w1*(1<<<1**5);
  assign w7 = w8+(-w1);
  assign w8 = (1<<<1**3)*w1;
  assign o_data0 = w28370;
endmodule

