module inverter_nick_yay_U1 (A_c, AnalogLDir_c, AnalogRDir_c, Ldir_c,
            n63)  ;
    input A_c;
    input AnalogLDir_c;
    input AnalogRDir_c;
    output Ldir_c;
    output n63;
    LUT4 i1_3_lut_3_lut (.A(A_c), .B(AnalogLDir_c), .C(AnalogRDir_c),
         .Z(Ldir_c))  ;
    defparam i1_3_lut_3_lut.init = 16'h8c8c;
    LUT4 i4_1_lut_rep_2 (.A(A_c), .Z(n63))  ;
    defparam i4_1_lut_rep_2.init = 16'h5555;
endmodule