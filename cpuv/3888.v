module sky130_fd_sc_hd__dfstp (
    input  D    , 
    output Q    , 
    input  SET_B, 
    input  CLK   
);
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule