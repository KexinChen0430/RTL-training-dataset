module RAM64X2S (...); 
    parameter [63:0] INIT_00 = 64'h0000000000000000; 
    parameter [63:0] INIT_01 = 64'h0000000000000000; 
    parameter [0:0] IS_WCLK_INVERTED = 1'b0; 
    output O0, O1; 
    input A0, A1, A2, A3, A4, A5, D0, D1, WCLK, WE; 
endmodule 