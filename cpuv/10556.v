module cpx_buf_p4_even(
   arbcp0_cpxdp_grant_ca, arbcp0_cpxdp_q0_hold_ca_l,
   arbcp0_cpxdp_qsel0_ca, arbcp0_cpxdp_qsel1_ca_l,
   arbcp0_cpxdp_shift_cx, arbcp2_cpxdp_grant_ca,
   arbcp2_cpxdp_q0_hold_ca_l, arbcp2_cpxdp_qsel0_ca,
   arbcp2_cpxdp_qsel1_ca_l, arbcp2_cpxdp_shift_cx,
   arbcp4_cpxdp_grant_ca, arbcp4_cpxdp_q0_hold_ca_l,
   arbcp4_cpxdp_qsel0_ca, arbcp4_cpxdp_qsel1_ca_l,
   arbcp4_cpxdp_shift_cx, arbcp6_cpxdp_grant_ca,
   arbcp6_cpxdp_q0_hold_ca_l, arbcp6_cpxdp_qsel0_ca,
   arbcp6_cpxdp_qsel1_ca_l, arbcp6_cpxdp_shift_cx,
   arbcp0_cpxdp_grant_bufp3_ca_l, arbcp0_cpxdp_q0_hold_bufp3_ca,
   arbcp0_cpxdp_qsel0_bufp3_ca_l, arbcp0_cpxdp_qsel1_bufp3_ca,
   arbcp0_cpxdp_shift_bufp3_cx_l, arbcp2_cpxdp_grant_bufp3_ca_l,
   arbcp2_cpxdp_q0_hold_bufp3_ca, arbcp2_cpxdp_qsel0_bufp3_ca_l,
   arbcp2_cpxdp_qsel1_bufp3_ca, arbcp2_cpxdp_shift_bufp3_cx_l,
   arbcp4_cpxdp_grant_bufp3_ca_l, arbcp4_cpxdp_q0_hold_bufp3_ca,
   arbcp4_cpxdp_qsel0_bufp3_ca_l, arbcp4_cpxdp_qsel1_bufp3_ca,
   arbcp4_cpxdp_shift_bufp3_cx_l, arbcp6_cpxdp_grant_bufp3_ca_l,
   arbcp6_cpxdp_q0_hold_bufp3_ca, arbcp6_cpxdp_qsel0_bufp3_ca_l,
   arbcp6_cpxdp_qsel1_bufp3_ca, arbcp6_cpxdp_shift_bufp3_cx_l
   );
   output 		arbcp0_cpxdp_grant_ca;
   output 		arbcp0_cpxdp_q0_hold_ca_l;
   output 		arbcp0_cpxdp_qsel0_ca;
   output 		arbcp0_cpxdp_qsel1_ca_l;
   output 		arbcp0_cpxdp_shift_cx;
   output 		arbcp2_cpxdp_grant_ca;
   output 		arbcp2_cpxdp_q0_hold_ca_l;
   output 		arbcp2_cpxdp_qsel0_ca;
   output 		arbcp2_cpxdp_qsel1_ca_l;
   output 		arbcp2_cpxdp_shift_cx;
   output 		arbcp4_cpxdp_grant_ca;
   output 		arbcp4_cpxdp_q0_hold_ca_l;
   output 		arbcp4_cpxdp_qsel0_ca;
   output 		arbcp4_cpxdp_qsel1_ca_l;
   output 		arbcp4_cpxdp_shift_cx;
   output 		arbcp6_cpxdp_grant_ca;
   output 		arbcp6_cpxdp_q0_hold_ca_l;
   output 		arbcp6_cpxdp_qsel0_ca;
   output 		arbcp6_cpxdp_qsel1_ca_l;
   output 		arbcp6_cpxdp_shift_cx;
   input		arbcp0_cpxdp_grant_bufp3_ca_l;
   input		arbcp0_cpxdp_q0_hold_bufp3_ca;
   input		arbcp0_cpxdp_qsel0_bufp3_ca_l;
   input		arbcp0_cpxdp_qsel1_bufp3_ca;
   input		arbcp0_cpxdp_shift_bufp3_cx_l;
   input		arbcp2_cpxdp_grant_bufp3_ca_l;
   input		arbcp2_cpxdp_q0_hold_bufp3_ca;
   input		arbcp2_cpxdp_qsel0_bufp3_ca_l;
   input		arbcp2_cpxdp_qsel1_bufp3_ca;
   input		arbcp2_cpxdp_shift_bufp3_cx_l;
   input		arbcp4_cpxdp_grant_bufp3_ca_l;
   input		arbcp4_cpxdp_q0_hold_bufp3_ca;
   input		arbcp4_cpxdp_qsel0_bufp3_ca_l;
   input		arbcp4_cpxdp_qsel1_bufp3_ca;
   input		arbcp4_cpxdp_shift_bufp3_cx_l;
   input		arbcp6_cpxdp_grant_bufp3_ca_l;
   input		arbcp6_cpxdp_q0_hold_bufp3_ca;
   input		arbcp6_cpxdp_qsel0_bufp3_ca_l;
   input		arbcp6_cpxdp_qsel1_bufp3_ca;
   input		arbcp6_cpxdp_shift_bufp3_cx_l;
   assign		arbcp0_cpxdp_grant_ca		   =    ~  arbcp0_cpxdp_grant_bufp3_ca_l;
   assign		arbcp0_cpxdp_q0_hold_ca_l	   =    ~ arbcp0_cpxdp_q0_hold_bufp3_ca;
   assign		arbcp0_cpxdp_qsel0_ca		   =    ~ arbcp0_cpxdp_qsel0_bufp3_ca_l;
   assign		arbcp0_cpxdp_qsel1_ca_l		   =    ~ arbcp0_cpxdp_qsel1_bufp3_ca;
   assign		arbcp0_cpxdp_shift_cx		   =    ~ arbcp0_cpxdp_shift_bufp3_cx_l;
   assign		arbcp2_cpxdp_grant_ca		   =    ~  arbcp2_cpxdp_grant_bufp3_ca_l;
   assign		arbcp2_cpxdp_q0_hold_ca_l	   =    ~ arbcp2_cpxdp_q0_hold_bufp3_ca;
   assign		arbcp2_cpxdp_qsel0_ca		   =    ~ arbcp2_cpxdp_qsel0_bufp3_ca_l;
   assign		arbcp2_cpxdp_qsel1_ca_l		   =    ~ arbcp2_cpxdp_qsel1_bufp3_ca;
   assign		arbcp2_cpxdp_shift_cx		   =    ~ arbcp2_cpxdp_shift_bufp3_cx_l;
   assign		arbcp4_cpxdp_grant_ca		   =    ~  arbcp4_cpxdp_grant_bufp3_ca_l;
   assign		arbcp4_cpxdp_q0_hold_ca_l	   =    ~ arbcp4_cpxdp_q0_hold_bufp3_ca;
   assign		arbcp4_cpxdp_qsel0_ca		   =    ~ arbcp4_cpxdp_qsel0_bufp3_ca_l;
   assign		arbcp4_cpxdp_qsel1_ca_l		   =    ~ arbcp4_cpxdp_qsel1_bufp3_ca;
   assign		arbcp4_cpxdp_shift_cx		   =    ~ arbcp4_cpxdp_shift_bufp3_cx_l;
   assign		arbcp6_cpxdp_grant_ca		   =    ~  arbcp6_cpxdp_grant_bufp3_ca_l;
   assign		arbcp6_cpxdp_q0_hold_ca_l	   =    ~ arbcp6_cpxdp_q0_hold_bufp3_ca;
   assign		arbcp6_cpxdp_qsel0_ca		   =    ~ arbcp6_cpxdp_qsel0_bufp3_ca_l;
   assign		arbcp6_cpxdp_qsel1_ca_l		   =    ~ arbcp6_cpxdp_qsel1_bufp3_ca;
   assign		arbcp6_cpxdp_shift_cx		   =    ~ arbcp6_cpxdp_shift_bufp3_cx_l;
endmodule