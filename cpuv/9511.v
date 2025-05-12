module sky130_fd_sc_hvl__lsbuflv2hv_clkiso_hlkg (
    input  A      , 
    output X      , 
    input  SLEEP_B  
);
    supply1 VPWR ; 
    supply0 VGND ; 
    supply1 LVPWR; 
    supply1 VPB  ; 
    supply0 VNB  ; 
endmodule