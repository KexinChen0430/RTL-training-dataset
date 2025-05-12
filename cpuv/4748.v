module sky130_fd_sc_hd__dfrbp (
    input  D      , 
    output Q      , 
    output Q_N    , 
    input  RESET_B, 
    input  CLK     
);
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule