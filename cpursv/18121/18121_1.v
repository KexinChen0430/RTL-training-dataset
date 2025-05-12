
module inverter_nick_yay_U0(B_c,Z_B);

  input  B_c;
  output Z_B;

  LUT4 i4_1_lut(.A(B_c),.Z(Z_B));
  defparam   i4_1_lut.init = 16'h5555;

endmodule

