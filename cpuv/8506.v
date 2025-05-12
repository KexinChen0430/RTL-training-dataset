module sky130_fd_sc_lp__sdfxbp ( 
    Q  , 
    Q_N, 
    CLK, 
    D  , 
    SCD, 
    SCE  
);
    output Q  ; 
    output Q_N; 
    input  CLK; 
    input  D  ; 
    input  SCD; 
    input  SCE; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 