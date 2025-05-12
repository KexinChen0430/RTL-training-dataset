
module MISTRAL_ALUT_ARITH(input  A,B,C,D0,D1,
                          input  CI,
                          output SO,
                          output CO);

  parameter  LUT0 = 16'h0000;
  parameter  LUT1 = 16'h0000;
  wire q0,q1;

  assign q0 = LUT0>>{D0,C,B,A};
  assign q1 = LUT1>>{D1,C,B,A};
  assign {CO,SO} = CI+(!q1+q0);
endmodule

