module sky130_fd_sc_hd__ebufn (
    Z   ,
    A   ,
    TE_B
);
    output Z   ; 
    input  A   ; 
    input  TE_B; 
    supply1 VPWR; 
    supply0 VGND; 
    supply1 VPB ; 
    supply0 VNB ; 
endmodule