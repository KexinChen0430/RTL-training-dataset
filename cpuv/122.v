module $__outpad (
    input I,  
    output O  
);
    PADOUT _TECHMAP_REPLACE_ (
        .padout(O), 
        .padin(I),  
        .oe(1'b1)   
    );
endmodule 