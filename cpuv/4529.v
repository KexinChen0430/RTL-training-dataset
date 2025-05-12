module sky130_fd_sc_lp__isobufsrc (
    input  A    , 
    output X    , 
    input  SLEEP 
);
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule