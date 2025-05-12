module sky130_fd_sc_hdll__muxb16to1 (
    input  [15:0] D,
    output        Z,
    input  [15:0] S
);
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;
endmodule