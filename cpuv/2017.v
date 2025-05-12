module sky130_fd_sc_hd__nand4bb (
    Y  ,
    A_N,
    B_N,
    C  ,
    D
);
    output Y  ; 
    input  A_N; 
    input  B_N; 
    input  C  ; 
    input  D  ; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule