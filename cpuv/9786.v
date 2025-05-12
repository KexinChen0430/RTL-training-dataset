module sky130_fd_sc_lp__srsdfxtp ( 
    Q      , 
    CLK    , 
    D      , 
    SCD    , 
    SCE    , 
    SLEEP_B  
);
    output Q      ; 
    input  CLK    ; 
    input  D      ; 
    input  SCD    ; 
    input  SCE    ; 
    input  SLEEP_B; 
    supply1 KAPWR; 
    supply1 VPWR ; 
    supply0 VGND ; 
    supply1 VPB  ; 
    supply0 VNB  ; 
endmodule 