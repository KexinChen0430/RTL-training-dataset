
module sky130_fd_io__top_sio(input  SLOW,
                             output IN,
                             input  INP_DIS,
                             output IN_H,
                             input  OUT,
                             inout  PAD,
                             inout  PAD_A_ESD_0_H,
                             inout  PAD_A_ESD_1_H,
                             inout  PAD_A_NOESD_H,
                             input  [2:0] DM,
                             input  ENABLE_H,
                             input  HLD_H_N,
                             input  HLD_OVR,
                             input  IBUF_SEL,
                             input  OE_N,
                             input  VREG_EN,
                             input  VTRIP_SEL,
                             input  REFLEAK_BIAS,
                             input  VINREF,
                             input  VOUTREF,
                             output TIE_LO_ESD);

  supply0 VSSIO;
  supply0 VSSIO_Q;
  supply0 VSSD;
  supply1 VCCD;
  supply1 VDDIO;
  supply1 VCCHIB;
  supply1 VDDIO_Q;


endmodule

