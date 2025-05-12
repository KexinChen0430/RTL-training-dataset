module IDDR (...); 
    parameter DDR_CLK_EDGE = "OPPOSITE_EDGE"; 
    parameter INIT_Q1 = 1'b0; 
    parameter INIT_Q2 = 1'b0; 
    parameter [0:0] IS_C_INVERTED = 1'b0; 
    parameter [0:0] IS_D_INVERTED = 1'b0; 
    parameter SRTYPE = "SYNC"; 
    parameter MSGON = "TRUE"; 
    parameter XON = "TRUE"; 
    output Q1; 
    output Q2; 
    input C; 
    input CE; 
    input D; 
    input R; 
    input S; 
endmodule 