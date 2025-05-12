
module inverter_nick_yay(C_c,AnalogLDir_c,AnalogRDir_c,Rdir_c,n62);

  input  C_c;
  input  AnalogLDir_c;
  input  AnalogRDir_c;
  output Rdir_c;
  output n62;

  LUT4 i1_3_lut_3_lut(.A(C_c),.B(AnalogLDir_c),.C(AnalogRDir_c),
                      .Z(Rdir_c));
  defparam   i1_3_lut_3_lut.init = 16'hb0b0;

  LUT4 i4_1_lut_rep_1(.A(C_c),.Z(n62));
  defparam   i4_1_lut_rep_1.init = 16'h5555;

endmodule

