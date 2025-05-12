module MISTRAL_ALUT4(input A, B, C, D, output Q);
    parameter [15:0] LUT = 16'h0000;
    `ifdef cyclonev
    specify
        (A => Q) = 510; 
        (B => Q) = 512; 
        (C => Q) = 400; 
        (D => Q) = 97;  
    endspecify
    `endif
    `ifdef cyclone10gx
    specify
        (A => Q) = 175; 
        (B => Q) = 165; 
        (C => Q) = 162; 
        (D => Q) = 53;  
    endspecify
    `endif
    assign Q = LUT >> {D, C, B, A};
endmodule 