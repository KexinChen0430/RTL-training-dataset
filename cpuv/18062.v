module SRL16E (...);
    parameter [15:0] INIT = 16'h0000;
    parameter [0:0] IS_CLK_INVERTED = 1'b0;
    output Q;
    input A0, A1, A2, A3, CE, CLK, D;
endmodule