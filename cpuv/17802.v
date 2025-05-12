module BUFGCE (...);
    parameter CE_TYPE = "SYNC";
    parameter [0:0] IS_CE_INVERTED = 1'b0;
    parameter [0:0] IS_I_INVERTED = 1'b0;
    output O;
    input CE;
    input I;
endmodule