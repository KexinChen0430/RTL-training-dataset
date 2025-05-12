module MISTRAL_ALUT_ARITH(input A, B, C, D0, D1,  input CI, output SO,  output CO);
parameter LUT0 = 16'h0000;
parameter LUT1 = 16'h0000;
`ifdef cyclonev
specify
    (A  => SO) = 1342;
    (B  => SO) = 1323;
    (C  => SO) = 927;
    (D0 => SO) = 887;
    (D1 => SO) = 785;
    (CI => SO) = 368;
    (A  => CO) = 1082;
    (B  => CO) = 1062;
    (C  => CO) = 813;
    (D0 => CO) = 866;
    (D1 => CO) = 1198;
    (CI => CO) = 36; 
endspecify
`endif
`ifdef arriav
specify
endspecify
`endif
`ifdef cyclone10gx
specify
endspecify
`endif
wire q0, q1;
assign q0 = LUT0 >> {D0, C, B, A};
assign q1 = LUT1 >> {D1, C, B, A};
assign {CO, SO} = q0 + !q1 + CI;
endmodule