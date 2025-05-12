module BSCANE2 (...);
    parameter DISABLE_JTAG = "FALSE";
    parameter integer JTAG_CHAIN = 1;
    output CAPTURE;
    output DRCK;
    output RESET;
    output RUNTEST;
    output SEL;
    output SHIFT;
    output TCK;
    output TDI;
    output TMS;
    output UPDATE;
    input TDO;
endmodule