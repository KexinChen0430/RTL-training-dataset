module sky130_fd_io__top_power_lvc_wpad ( P_PAD, AMUXBUS_A, AMUXBUS_B
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply0 src_bdy_lvc1;
supply0 src_bdy_lvc2;
supply1 ogc_lvc;
supply1 drn_lvc1;
supply1 bdy2_b2b;
supply0 drn_lvc2;
supply1 p_core;
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
assign p_core = P_PAD;
endmodule