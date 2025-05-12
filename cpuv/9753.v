module sky130_fd_sc_lp__sdfrbp (
    input  D      , 
    output Q      , 
    output Q_N    , 
    input  RESET_B, 
    input  SCD    , 
    input  SCE    , 
    input  CLK     
);
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule