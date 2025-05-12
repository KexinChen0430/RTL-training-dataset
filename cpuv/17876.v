module RAM64X1S (...);
    parameter [63:0] INIT = 64'h0000000000000000;
    parameter [0:0] IS_WCLK_INVERTED = 1'b0;
    output O;
    input A0, A1, A2, A3, A4, A5;
    input D;
    input WCLK;
    input WE;
endmodule