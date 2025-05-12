module BB(input T, I, output O,
    (* iopad_external_pin *) inout B); 
    assign B = T ? 1'bz : I; 
    assign O = B; 
endmodule 