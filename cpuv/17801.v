module BUFHCE (...); 
    parameter CE_TYPE = "SYNC"; 
    parameter integer INIT_OUT = 0; 
    parameter [0:0] IS_CE_INVERTED = 1'b0; 
    output O; 
    input CE; 
    input I; 
endmodule 