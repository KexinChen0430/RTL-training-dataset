module sky130_fd_sc_lp__dlxbp (
    Q   ,
    Q_N ,
    D   ,
    GATE
);
    output Q   ;
    output Q_N ;
    input  D   ;
    input  GATE;
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;
endmodule