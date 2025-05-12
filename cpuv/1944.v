module EXTREFB (
    input  REFCLKP, 
    REFCLKN,        
    output REFCLKO  
);
    parameter REFCK_PWDNB = "0b0";
    parameter REFCK_RTERM = "0b0";
    parameter REFCK_DCBIAS_EN = "0b0";
endmodule