module sky130_fd_sc_lp__lsbuf ( 
    X, 
    A  
);
    output X; 
    input  A; 
    supply1 DESTPWR; 
    supply1 VPWR   ; 
    supply0 VGND   ; 
    supply1 DESTVPB; 
    supply1 VPB    ; 
    supply0 VNB    ; 
endmodule 