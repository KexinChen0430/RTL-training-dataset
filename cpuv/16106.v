module MISTRAL_ALUT2(input A, B, output Q);
parameter [3:0] LUT = 4'h0;
`ifdef cyclonev
specify
    (A => Q) = 400; 
    (B => Q) = 97;  
endspecify
`endif
`ifdef arriav
specify
    (A => Q) = 316; 
    (B => Q) = 76;  
endspecify
`endif
`ifdef cyclone10gx
specify
    (A => Q) = 162; 
    (B => Q) = 53;  
endspecify
`endif
assign Q = LUT >> {B, A};
endmodule