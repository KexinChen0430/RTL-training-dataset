module __MISTRAL_GND(
    output Q  
);
    MISTRAL_ALUT2 #(
        .LUT(4'b0000)  
    ) _TECHMAP_REPLACE_ (
        .A(1'b1),  
        .B(1'b1),  
        .Q(Q)      
    );
endmodule