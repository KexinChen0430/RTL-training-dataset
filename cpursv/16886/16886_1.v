
module \$_SDFFE_NP1P_(input  D,C,R,E,
                      output Q);

  DFFNSE _TECHMAP_REPLACE_(.D(D),.Q(Q),.CLK(C),.SET(R),.CE(E));
  wire  _TECHMAP_REMOVEINIT_Q_ = 1;

endmodule

