module sky130_fd_sc_hdll__mux2i (
    Y ,
    A0,
    A1,
    S
);
    output Y ;
    input  A0;
    input  A1;
    input  S ;
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;
endmodule