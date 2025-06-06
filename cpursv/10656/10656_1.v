
module sky130_fd_io__top_xres4v2(XRES_H_N,AMUXBUS_A,AMUXBUS_B,PAD,DISABLE_PULLUP_H,ENABLE_H,
                                 EN_VDDIO_SIG_H,INP_SEL_H,FILT_IN_H,PULLUP_H,ENABLE_VDDIO,
                                 PAD_A_ESD_H,TIE_HI_ESD,TIE_LO_ESD,TIE_WEAK_HI_H);

  output XRES_H_N;
  inout  AMUXBUS_A;
  inout  AMUXBUS_B;
  inout  PAD;
  input  DISABLE_PULLUP_H;
  input  ENABLE_H;
  input  EN_VDDIO_SIG_H;
  input  INP_SEL_H;
  input  FILT_IN_H;
  inout  PULLUP_H;
  input  ENABLE_VDDIO;
  inout  PAD_A_ESD_H;
  output TIE_HI_ESD;
  output TIE_LO_ESD;
  inout  TIE_WEAK_HI_H;
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

