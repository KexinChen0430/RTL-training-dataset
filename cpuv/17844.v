module IOBUFDS_DIFF_OUT_INTERMDISABLE (...);
    parameter DIFF_TERM = "FALSE";
    parameter DQS_BIAS = "FALSE";
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";
    parameter SIM_DEVICE = "7SERIES";
    parameter USE_IBUFDISABLE = "TRUE";
    output O;
    output OB;
    input I;
    input IBUFDISABLE;
    input INTERMDISABLE;
    input TM;
    input TS;
endmodule