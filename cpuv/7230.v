module sky130_fd_sc_ls__dlrtp (
    input  D      , 
    output Q      , 
    input  RESET_B, 
    input  GATE    
);
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule