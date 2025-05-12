module sky130_fd_sc_ls__dlrbp ( 
    Q      , 
    Q_N    , 
    RESET_B, 
    D      , 
    GATE   
);
    output Q      ; 
    output Q_N    ; 
    input  RESET_B; 
    input  D      ; 
    input  GATE   ; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 