
module MISTRAL_ALUT5(input  A,B,C,D,E,
                     output Q);

  parameter [31:0]  LUT = 32'h0000_0000;

  assign Q = LUT>>{E,D,C,B,A};
endmodule

