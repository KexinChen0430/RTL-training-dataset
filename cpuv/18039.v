module IOBUF_DCIEN (...);
    parameter integer DRIVE = 12;
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";
    parameter SIM_DEVICE = "7SERIES";
    parameter SLEW = "SLOW";
    parameter USE_IBUFDISABLE = "TRUE";
    output O;
    input DCITERMDISABLE;
    input I;
    input IBUFDISABLE;
    input T;
endmodule