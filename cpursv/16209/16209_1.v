
module MISTRAL_ALUT3(input  A,B,C,
                     output Q);

  parameter [7:0]  LUT = 8'h00;

  assign Q = LUT>>{C,B,A};
endmodule

