module sky130_fd_io__top_power_hvc_wpad ( P_PAD, AMUXBUS_A, AMUXBUS_B
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
supply1 ogc_hvc;
supply1 drn_hvc;
supply0 src_bdy_hvc;
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