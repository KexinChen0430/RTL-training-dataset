module sky130_fd_sc_hvl__lsbuflv2hv_symmetric (
    X,
    A
);
    output X; 
    input  A; 
    supply1 VPWR ; 
    supply0 VGND ; 
    supply1 LVPWR; 
    supply1 VPB  ; 
    supply0 VNB  ; 
endmodule