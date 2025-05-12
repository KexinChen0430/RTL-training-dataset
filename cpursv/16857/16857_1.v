
module \$_SDFF_NP1_(input  D,C,R,
                    output Q);

  DFFNS _TECHMAP_REPLACE_(.D(D),.Q(Q),.CLK(C),.SET(R));
  wire  _TECHMAP_REMOVEINIT_Q_ = 1;

endmodule

