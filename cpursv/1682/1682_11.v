
module spiral_16(i_data,o_data_4,o_data_13,o_data_22,o_data_31,o_data_38,
                 o_data_46,o_data_54,o_data_61,o_data_67,o_data_73,o_data_78,
                 o_data_82,o_data_85,o_data_88,o_data_90);

  input  signed  [16:0] i_data;
  output signed  [16+7:0] o_data_4;
  wire signed  [23:0] 
      w1 ,
      w32,
      w31,
      w8 ,
      w23,
      w4 ,
      w27,
      w39,
      w62,
      w61,
      w9 ,
      w2 ,
      w11,
      w13,
      w18,
      w19,
      w41,
      w36,
      w45,
      w67,
      w64,
      w73,
      w16,
      w17,
      w68,
      w85,
      w22,
      w38,
      w46,
      w54,
      w78,
      w82,
      w88,
      w90;

  assign w1 = i_data;
  assign w32 = (1<<1**5)*w1;
  assign w31 = w32+(0-w1);
  assign w8 = w1<<3;
  assign o_data_4 = w4;
  assign o_data_13 = w13;
  assign o_data_22 = w22;
  assign o_data_31 = w31;
  assign o_data_38 = w38;
  assign o_data_46 = w46;
  assign o_data_54 = w54;
  assign o_data_61 = w61;
  assign o_data_67 = w67;
  assign o_data_73 = w73;
  assign o_data_78 = w78;
  assign o_data_82 = w82;
  assign o_data_85 = w85;
  assign o_data_88 = w88;
  assign o_data_90 = w90;
endmodule

