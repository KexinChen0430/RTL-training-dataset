module sky130_fd_sc_hs__dfsbp (
    CLK  ,
    D    ,
    Q    ,
    Q_N  ,
    SET_B
);
    input  CLK  ;
    input  D    ;
    output Q    ;
    output Q_N  ;
    input  SET_B;
    supply1 VPWR;
    supply0 VGND;
endmodule