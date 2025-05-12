module ICAPE2 (...);
    parameter [31:0] DEVICE_ID = 32'h04244093;
    parameter ICAP_WIDTH = "X32";
    parameter SIM_CFG_FILE_NAME = "NONE";
    output [31:0] O;
    input CLK;
    input CSIB;
    input RDWRB;
    input [31:0] I;
endmodule