module sky130_fd_sc_hvl__lsbufhv2lv_simple (
    X,
    A
);
    output X;
    input  A;
    supply1 VPWR ;
    supply0 VGND ;
    supply1 LVPWR;
    supply1 VPB  ;
    supply0 VNB  ;
endmodule