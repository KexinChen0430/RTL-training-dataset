module MISTRAL_NOT(
    input A,  
    output Q  
);
`ifdef cyclonev
specify
    (A => Q) = 97;
endspecify
`endif 
`ifdef cyclone10gx
specify
    (A => Q) = 53;
endspecify
`endif 
assign Q = ~A;
endmodule 