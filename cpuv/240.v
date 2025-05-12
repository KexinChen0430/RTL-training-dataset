module BB(
    input T,  
    input I,  
    output O, 
    (* iopad_external_pin *) inout B 
);
    assign B = T ? 1'bz : O;
    assign I = B;
endmodule