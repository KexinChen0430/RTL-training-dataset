module $__ABC9_LUT5 (
    input SEL, 
    input D,   
    input C,   
    input B,   
    input A,   
    output Z   
);
    specify
        (SEL => Z) = 171; 
        (D => Z) = 303;   
        (C => Z) = 311;   
        (B => Z) = 309;   
        (A => Z) = 306;   
    endspecify
endmodule 