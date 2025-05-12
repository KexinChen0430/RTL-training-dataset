
module MISTRAL_ALUT6(input  A,B,C,D,E,F,
                     output Q);

  parameter [63:0]  LUT = 64'h0000_0000_0000_0000;

  assign Q = LUT>>{F,E,D,C,B,A};
endmodule

