module sky130_fd_sc_hd__dlrbn ( 
    Q      , 
    Q_N    , 
    RESET_B, 
    D      , 
    GATE_N  
);
    output Q      ; 
    output Q_N    ; 
    input  RESET_B; 
    input  D      ; 
    input  GATE_N ; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 