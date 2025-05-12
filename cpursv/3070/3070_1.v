
module sky130_fd_io__top_xres4v2(input  FILT_IN_H,
                                 input  INP_SEL_H,
                                 inout  PAD,
                                 inout  PAD_A_ESD_H,
                                 inout  AMUXBUS_A,
                                 inout  AMUXBUS_B,
                                 input  DISABLE_PULLUP_H,
                                 input  ENABLE_H,
                                 input  ENABLE_VDDIO,
                                 input  EN_VDDIO_SIG_H,
                                 output XRES_H_N,
                                 inout  PULLUP_H,
                                 output TIE_HI_ESD,
                                 inout  TIE_WEAK_HI_H,
                                 output TIE_LO_ESD);

  supply1 VCCD;
  supply1 VCCHIB;
  supply1 VDDA;
  supply1 VDDIO;
  supply1 VDDIO_Q;
  supply0 VSSA;
  supply0 VSSD;
  supply0 VSSIO;
  supply0 VSSIO_Q;
  supply1 VSWITCH;


endmodule

