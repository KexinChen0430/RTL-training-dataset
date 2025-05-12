module LDCE (...); 
    parameter [0:0] INIT = 1'b0;
    parameter [0:0] IS_CLR_INVERTED = 1'b0;
    parameter [0:0] IS_G_INVERTED = 1'b0;
    parameter MSGON = "TRUE";
    parameter XON = "TRUE";
    output Q;
    input CLR, D, G, GE;
endmodule 