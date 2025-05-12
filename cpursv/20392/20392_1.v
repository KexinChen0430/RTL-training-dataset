
module \$_DLATCH_PN0_(input  D,R,E,
                      output Q);

  SLE _TECHMAP_REPLACE_(.D(D),.CLK(E),.EN(1'b1),.ALn(R),.ADn(1'b1),
                        .SLn(1'b1),.SD(1'b0),.LAT(1'b1),.Q(Q));
endmodule

