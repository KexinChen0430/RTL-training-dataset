module sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell (
    X,
    A
);
    output X;
    input  A;
    wire    LOWLVPWR;
    supply1 VPWR    ;
    supply0 VGND    ;
    supply1 VPB     ;
    supply0 VNB     ;
endmodule