
module \$_SDFFCE_PN1P_(input  D,C,R,E,
                       output Q);

  SLE _TECHMAP_REPLACE_(.D(D),.CLK(C),.EN(E),.ALn(1'b1),.ADn(1'b0),
                        .SLn(R),.SD(1'b1),.LAT(1'b0),.Q(Q));
endmodule

