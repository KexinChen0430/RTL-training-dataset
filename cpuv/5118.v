module bSbox ( A, Q ); 
    input [7:0] A; 
    output [7:0] Q; 
    wire [7:0] B, C; 
    wire R1, R2, R3, R4, R5, R6, R7, R8, R9; 
    wire T1, T2, T3, T4, T5, T6, T7, T8, T9; 
    assign R1 = A[7] ^ A[5] ;
    assign B[7] = R7 ^ R8 ;
    GF_INV_8 inv( B, C ); 
    assign T1 = C[7] ^ C[3] ;
    assign Q[7] = T4 ;
endmodule 