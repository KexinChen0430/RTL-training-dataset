module sky130_fd_sc_hd__fahcon (
    COUT_N,
    SUM   ,
    A     ,
    B     ,
    CI
);
    output COUT_N;
    output SUM   ;
    input  A     ;
    input  B     ;
    input  CI    ;
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;
endmodule