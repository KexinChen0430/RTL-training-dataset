module $__NX_TINOUTPAD (
    input I,   
    input OE,  
    output O,  
    inout B    
);
    BB _TECHMAP_REPLACE_ (
        .I(I),  
        .O(O),  
        .T(~OE), 
        .B(B)   
    );
endmodule 