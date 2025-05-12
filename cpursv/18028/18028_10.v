
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
  assign w112 = (2**4)*w7;
  assign w14185 = w14297+(-w112);
  assign w14297 = (0-w32)+w14329;
  assign w14329 = w14336-w7;
  assign w14336 = (2**11)*w7;
  assign w28370 = w14185*2;
  assign w32 = w1<<5;
  assign w7 = w8-w1;
  assign w8 = w1<<3;
  assign o_data0 = w28370;
endmodule

