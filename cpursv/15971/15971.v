
module sky130_fd_io__top_ground_hvc_wpad(G_PAD,AMUXBUS_A,AMUXBUS_B);

  inout  G_PAD;
  inout  AMUXBUS_A;
  inout  AMUXBUS_B;
  supply1 ogc_hvc;
  supply1 drn_hvc;
  supply0 src_bdy_hvc;
  supply0 g_core;
  supply1 vddio;
  supply1 vddio_q;
  supply1 vdda;
  supply1 vccd;
  supply1 vswitch;
  supply1 vcchib;
  supply1 vpb;
  supply1 vpbhib;
  supply0 vssd;
  supply0 vssio;
  supply0 vssio_q;
  supply0 vssa;

  assign g_core = G_PAD;
endmodule

