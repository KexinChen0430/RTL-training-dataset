module  \$_DLATCHSR_PPP_ (input E, S, R, D, output Q); 
    latchsre _TECHMAP_REPLACE_ (.D(D), .Q(Q), .E(1'b1), .G(E),  .R(!R), .S(!S)); 
endmodule 