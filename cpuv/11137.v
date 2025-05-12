module sky130_fd_sc_lp__srdlrtp ( 
    input  D      , 
    output Q      , 
    input  RESET_B, 
    input  GATE   , 
    input  SLEEP_B 
);
    supply1 KAPWR; 
    supply1 VPWR ; 
    supply0 VGND ; 
    supply1 VPB  ; 
    supply0 VNB  ; 
endmodule 