module sky130_fd_sc_ms__sdfbbn (
    input  D      , 
    output Q      , 
    output Q_N    , 
    input  RESET_B, 
    input  SET_B  , 
    input  SCD    , 
    input  SCE    , 
    input  CLK_N  
);
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule