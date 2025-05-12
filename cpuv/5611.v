module sky130_fd_sc_hdll__inputiso1n (
    X      , 
    A      , 
    SLEEP_B 
);
    output X      ; 
    input  A      ; 
    input  SLEEP_B; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule 