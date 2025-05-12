module \$_SDFFE_NP0P_ (input D, C, R, E, output Q);
    DFFNRE _TECHMAP_REPLACE_ (.D(D), .Q(Q), .CLK(C), .RESET(R), .CE(E));
    wire _TECHMAP_REMOVEINIT_Q_ = 1;
endmodule