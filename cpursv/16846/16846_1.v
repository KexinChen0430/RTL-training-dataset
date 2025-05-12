
module \$_SDFFE_PP1P_(input  D,C,R,E,
                      output Q);

  DFFSE _TECHMAP_REPLACE_(.D(D),.Q(Q),.CLK(C),.SET(R),.CE(E));
  wire  _TECHMAP_REMOVEINIT_Q_ = 1;

endmodule

