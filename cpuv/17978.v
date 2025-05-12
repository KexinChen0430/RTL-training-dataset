module IOBUFDS_DIFF_OUT (...);
    parameter DIFF_TERM = "FALSE";
    parameter DQS_BIAS = "FALSE";
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";
    output O;
    output OB;
    input I;
    input TM;
    input TS;
endmodule