module OBZ(
    input I,  
    input T,  
    (* iopad_external_pin *) output O  
);
    assign O = T ? 1'bz : I; 
endmodule 