module op_00(
    output Z, 
    input A,  
    input B   
);
    or2 o(
        .Z(Z), 
        .A(A), 
        .B(B)  
    );
endmodule 