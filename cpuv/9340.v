module  \$_DLATCHSR_NPP_ (input E, S, R, D, output Q); 
    latchnsre _TECHMAP_REPLACE_ (.D(D), .Q(Q), .E(1'b1), .G(E),  .R(!R), .S(!S)); 
endmodule 