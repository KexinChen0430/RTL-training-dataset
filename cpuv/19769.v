module \$_DFFE_PN1P_ (input D, C, R, E, output Q); 
  SLE _TECHMAP_REPLACE_ (.D(D), .CLK(C), .EN(E), .ALn(R), .ADn(1'b0), .SLn(1'b1), .SD(1'b0), .LAT(1'b0), .Q(Q)); 
endmodule 