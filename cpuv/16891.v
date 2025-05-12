module \$_DFFE_NP_ (input D, C, E, output Q);
    DFFNE _TECHMAP_REPLACE_ (.D(D), .Q(Q), .CLK(C), .CE(E));
    wire _TECHMAP_REMOVEINIT_Q_ = 1;
endmodule