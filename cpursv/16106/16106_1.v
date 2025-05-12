
module MISTRAL_ALUT2(input  A,B,
                     output Q);

  parameter [3:0]  LUT = 4'h0;

  assign Q = LUT>>{B,A};
endmodule

