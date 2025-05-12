module sky130_fd_sc_hs__dlrbp (
    RESET_B, 
    D       , 
    GATE    , 
    Q       , 
    Q_N     
);
    input  RESET_B; 
    input  D      ; 
    input  GATE   ; 
    output Q      ; 
    output Q_N    ; 
    supply1 VPWR; 
    supply0 VGND; 
endmodule