module STARTUPE2 (...); 
    parameter PROG_USR = "FALSE"; 
    parameter real SIM_CCLK_FREQ = 0.0; 
    output CFGCLK; 
    output CFGMCLK; 
    output EOS; 
    output PREQ; 
    input CLK; 
    input GSR; 
    input GTS; 
    input KEYCLEARB; 
    input PACK; 
    input USRCCLKO; 
    input USRCCLKTS; 
    input USRDONEO; 
    input USRDONETS; 
endmodule 