module sky130_fd_sc_lp__fah ( 
    COUT, 
    SUM , 
    A   , 
    B   , 
    CI   
);
    output COUT; 
    output SUM ; 
    input  A   ; 
    input  B   ; 
    input  CI  ; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 