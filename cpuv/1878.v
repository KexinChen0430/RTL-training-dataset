module sky130_fd_sc_hvl__lsbuflv2hv_isosrchvaon (
    X      ,
    A      ,
    SLEEP_B
);
    output X      ; 
    input  A      ; 
    input  SLEEP_B; 
    supply1 VPWR ; 
    supply0 VGND ; 
    supply1 LVPWR; 
    supply1 VPB  ; 
    supply0 VNB  ; 
endmodule