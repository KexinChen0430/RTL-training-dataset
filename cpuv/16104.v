module MISTRAL_ALUT5(input A, B, C, D, E, output Q);
parameter [31:0] LUT = 32'h0000_0000;
`ifdef cyclonev
specify
    (A => Q) = 583;
    (B => Q) = 510;
    (C => Q) = 512;
    (D => Q) = 400;
    (E => Q) = 97;
endspecify
`endif
`ifdef arriav
specify
    (A => Q) = 375;
    (B => Q) = 316;
    (C => Q) = 317;
    (D => Q) = 319;
    (E => Q) = 76;
endspecify
`endif
`ifdef cyclone10gx
specify
    (A => Q) = 272;
    (B => Q) = 175;
    (C => Q) = 165;
    (D => Q) = 162;
    (E => Q) = 53;
endspecify
`endif
assign Q = LUT >> {E, D, C, B, A};
endmodule