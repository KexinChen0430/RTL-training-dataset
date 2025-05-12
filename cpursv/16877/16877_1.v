
module \$_DFFE_PP1P_(input  D,C,R,E,
                     output Q);

  DFFPE _TECHMAP_REPLACE_(.D(D),.Q(Q),.CLK(C),.PRESET(R),.CE(E));
  wire  _TECHMAP_REMOVEINIT_Q_ = 1;

endmodule

