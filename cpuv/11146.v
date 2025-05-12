module sky130_fd_sc_hdll__sdfstp ( 
    Q    , 
    CLK  , 
    D    , 
    SCD  , 
    SCE  , 
    SET_B 
);
    output Q    ; 
    input  CLK  ; 
    input  D    ; 
    input  SCD  ; 
    input  SCE  ; 
    input  SET_B; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 