module ODDR (...); 
    output Q; 
    input C; 
    input CE; 
    input D1; 
    input D2; 
    input R; 
    input S; 
    parameter DDR_CLK_EDGE = "OPPOSITE_EDGE"; 
    parameter INIT = 1'b0; 
    parameter [0:0] IS_C_INVERTED = 1'b0; 
    parameter [0:0] IS_D1_INVERTED = 1'b0; 
    parameter [0:0] IS_D2_INVERTED = 1'b0; 
    parameter SRTYPE = "SYNC"; 
    parameter MSGON = "TRUE"; 
    parameter XON = "TRUE"; 
endmodule 