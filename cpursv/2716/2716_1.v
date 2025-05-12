
module MISTRAL_ALUT4(input  A,B,C,D,
                     output Q);

  parameter [15:0]  LUT = 16'h0000;

  assign Q = LUT>>{D,C,B,A};
endmodule

