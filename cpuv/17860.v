module RAM32X2S (...);
    parameter [31:0] INIT_00 = 32'h00000000;
    parameter [31:0] INIT_01 = 32'h00000000;
    parameter [0:0] IS_WCLK_INVERTED = 1'b0;
    output O0, O1;
    input A0, A1, A2, A3, A4;
    input D0, D1;
    input WCLK;
    input WE;
endmodule