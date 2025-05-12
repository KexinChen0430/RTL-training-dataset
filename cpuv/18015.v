module IBUFDS (...); 
    parameter CAPACITANCE = "DONT_CARE"; 
    parameter DIFF_TERM = "FALSE"; 
    parameter DQS_BIAS = "FALSE"; 
    parameter IBUF_DELAY_VALUE = "0"; 
    parameter IBUF_LOW_PWR = "TRUE"; 
    parameter IFD_DELAY_VALUE = "AUTO"; 
    parameter IOSTANDARD = "DEFAULT"; 
    output O; 
    input I, IB; 
endmodule 