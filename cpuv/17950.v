module PULLDHD (Z, EN); 
    output Z; 
    input  EN; 
    bufif0 _i0 (Z, 1'b0, EN); 
    specify 
        (EN => Z) = (0,0,0,0,0,0); 
    endspecify 
endmodule 