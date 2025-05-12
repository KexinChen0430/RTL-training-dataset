module sky130_fd_sc_ms__nand3b (
    Y  ,
    A_N,
    B  ,
    C
);
    output Y  ;
    input  A_N;
    input  B  ;
    input  C  ;
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;
endmodule