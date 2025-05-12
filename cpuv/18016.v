module SRLC32E (...);
    parameter [31:0] INIT = 32'h00000000;
    parameter [0:0] IS_CLK_INVERTED = 1'b0;
    output Q;
    output Q31;
    input [4:0] A;
    input CE, CLK, D;
endmodule