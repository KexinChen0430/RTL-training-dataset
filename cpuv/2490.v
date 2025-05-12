module sky130_fd_sc_lp__lsbufiso0p (
    X    ,
    SLEEP,
    A
);
    output X    ; 
    input  SLEEP; 
    input  A    ; 
    supply1 DESTPWR; 
    supply1 VPWR   ; 
    supply0 VGND   ; 
    supply1 DESTVPB; 
    supply1 VPB    ; 
    supply0 VNB    ; 
endmodule