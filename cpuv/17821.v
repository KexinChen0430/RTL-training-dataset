module CFGLUT5 (...);
    parameter [31:0] INIT = 32'h00000000;
    parameter [0:0] IS_CLK_INVERTED = 1'b0;
    output CDO;
    output O5;
    output O6;
    input I4, I3, I2, I1, I0;
    input CDI;
    input CE;
    input CLK;
endmodule