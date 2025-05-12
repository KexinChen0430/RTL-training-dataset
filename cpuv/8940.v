module sky130_fd_sc_lp__dfsbp ( 
    Q    , 
    Q_N  , 
    CLK  , 
    D    , 
    SET_B 
);
    output Q    ; 
    output Q_N  ; 
    input  CLK  ; 
    input  D    ; 
    input  SET_B; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 