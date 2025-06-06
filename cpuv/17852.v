module IBUF_INTERMDISABLE (...);
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";
    parameter SIM_DEVICE = "7SERIES";
    parameter USE_IBUFDISABLE = "TRUE";
    output O;
    input I;
    input IBUFDISABLE;
    input INTERMDISABLE;
endmodule