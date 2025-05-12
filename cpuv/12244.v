module sky130_fd_sc_lp__srsdfrtn (
    input  D      , 
    output Q      , 
    input  RESET_B, 
    input  SCD    , 
    input  SCE    , 
    input  CLK_N  , 
    input  SLEEP_B 
);
    supply1 KAPWR; 
    supply1 VPWR ; 
    supply0 VGND ; 
    supply1 VPB  ; 
    supply0 VNB  ; 
endmodule 