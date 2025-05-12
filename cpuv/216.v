module $__inpad (
    input I,  
    output O  
);
    PADIN _TECHMAP_REPLACE_ (
        .padout(O), 
        .padin(I)   
    );
endmodule