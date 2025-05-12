module sky130_fd_sc_lp__inputiso1n (
    input  A      , 
    output X      , 
    input  SLEEP_B  
);
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule