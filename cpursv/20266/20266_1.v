
module sky130_fd_io__top_sio_macro(AMUXBUS_A,AMUXBUS_B,VINREF_DFT,VOUTREF_DFT,DFT_REFGEN,
                                   HLD_H_N_REFGEN,IBUF_SEL_REFGEN,ENABLE_VDDA_H,ENABLE_H,VOHREF,
                                   VREG_EN_REFGEN,VTRIP_SEL_REFGEN,TIE_LO_ESD,IN_H,IN,
                                   PAD_A_NOESD_H,PAD,PAD_A_ESD_1_H,PAD_A_ESD_0_H,SLOW,VTRIP_SEL,
                                   HLD_H_N,VREG_EN,VOH_SEL,INP_DIS,HLD_OVR,OE_N,VREF_SEL,
                                   IBUF_SEL,DM0,DM1,OUT);

  inout  AMUXBUS_A;
  inout  AMUXBUS_B;
  inout  VINREF_DFT;
  inout  VOUTREF_DFT;
  input  DFT_REFGEN;
  input  HLD_H_N_REFGEN;
  input  IBUF_SEL_REFGEN;
  input  ENABLE_VDDA_H;
  input  ENABLE_H;
  input  VOHREF;
  input  VREG_EN_REFGEN;
  input  VTRIP_SEL_REFGEN;
  output [1:0] TIE_LO_ESD;
  output [1:0] IN_H;
  output [1:0] IN;
  inout  [1:0] PAD_A_NOESD_H;
  inout  [1:0] PAD;
  inout  [1:0] PAD_A_ESD_1_H;
  inout  [1:0] PAD_A_ESD_0_H;
  input  [1:0] SLOW;
  input  [1:0] VTRIP_SEL;
  input  [1:0] HLD_H_N;
  input  [1:0] VREG_EN;
  input  [2:0] VOH_SEL;
  input  [1:0] INP_DIS;
  input  [1:0] HLD_OVR;
  input  [1:0] OE_N;
  input  [1:0] VREF_SEL;
  input  [1:0] IBUF_SEL;
  input  [2:0] DM0;
  input  [2:0] DM1;
  input  [1:0] OUT;
  supply1 VCCD;
  supply1 VCCHIB;
  supply1 VDDA;
  supply1 VDDIO;
  supply1 VDDIO_Q;
  supply0 VSSD;
  supply0 VSSIO;
  supply0 VSSIO_Q;
  supply1 VSWITCH;
  supply0 VSSA;


endmodule

