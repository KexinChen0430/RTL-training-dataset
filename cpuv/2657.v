module sky130_fd_sc_ms__sdfbbp (
    Q        , 
    Q_N      , 
    D        , 
    SCD      , 
    SCE      , 
    CLK      , 
    SET_B    , 
    RESET_B  
);
    output Q      ; 
    output Q_N    ; 
    input  D      ; 
    input  SCD    ; 
    input  SCE    ; 
    input  CLK    ; 
    input  SET_B  ; 
    input  RESET_B; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule