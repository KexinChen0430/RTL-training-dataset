
module sky130_fd_io__top_ground_hvc_wpad(G_PAD,AMUXBUS_A,AMUXBUS_B);

  inout  G_PAD;
  inout  AMUXBUS_A;
  inout  AMUXBUS_B;
  supply1 OGC_HVC;
  supply1 DRN_HVC;
  supply0 SRC_BDY_HVC;
  supply0 G_CORE;
  supply1 VDDIO;
  supply1 VDDIO_Q;
  supply1 VDDA;
  supply1 VCCD;
  supply1 VSWITCH;
  supply1 VCCHIB;
  supply0 VSSA;
  supply0 VSSD;
  supply0 VSSIO_Q;
  supply0 VSSIO;


endmodule

